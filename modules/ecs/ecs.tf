/*====
Cloudwatch Log Group
======*/
resource "aws_cloudwatch_log_group" "app" {
  name              = "${var.application_name}-${var.environment}"
  retention_in_days = var.log_retention_in_days
  tags = {
    Environment = var.environment
    Application = var.application_name
  }
}

/*====
IAM service roles and policies
======*/

data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app_ecs_role" {
  name               = "${var.application_name}_${var.environment}_ecs_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

/* ecs service scheduler role */
resource "aws_iam_role_policy" "app_ecs_service_role_policy" {
  name = "${var.application_name}_${var.environment}_ecs_service_role_policy"
  policy = file("${path.module}/policies/ecs-service-role.json")
  role = aws_iam_role.app_ecs_role.id
}

/* role that the Amazon ECS container agent and the Docker daemon can assume */
resource "aws_iam_role" "app_ecs_execution_role" {
  name = "${var.application_name}_${var.environment}_ecs_task_execution_role"
  assume_role_policy = file("${path.module}/policies/ecs-task-execution-role.json")
}

resource "aws_iam_role_policy" "app_ecs_execution_role_policy" {
  name = "${var.application_name}_${var.environment}_ecs_execution_role_policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role = aws_iam_role.app_ecs_execution_role.id
}

/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.application_name}-${var.environment}-ecs-cluster"
}

/*====
ECS task definitions
======*/

/* the task definition for the app service */
data "template_file" "app_task" {
  template = file("${path.module}/tasks/app_task_definition.json")

  vars = {
    name             = var.application_name
    image            = "${var.ecr_repository_url}:${var.image_tag}"
    region           = var.region
    health_check_url = var.health_check_url
    log_group        = aws_cloudwatch_log_group.app.name
    env_vars = jsonencode(var.env_vars)
  }
}

resource "aws_ecs_task_definition" "app" {
  family                = "${var.application_name}_${var.environment}"
  container_definitions = data.template_file.app_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = "512"
  memory                = "2048"
  execution_role_arn    = aws_iam_role.app_ecs_execution_role.arn
  task_role_arn         = aws_iam_role.app_ecs_execution_role.arn
}


/*====
ECS service
======*/

/* Security Group for ECS */
resource "aws_security_group" "app_ecs_service" {
  vpc_id      = var.vpc_id
  name        = "${var.application_name}-${var.environment}-ecs-service-sg"
  description = "Allow egress from container"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allows traffic from the SG itself
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name        = "${var.application_name}-${var.environment}-ecs-service-sg"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "app" {
  name                               = "${var.application_name}-${var.environment}"
  task_definition                    = aws_ecs_task_definition.app.family
  desired_count                      = var.min_capacity
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "50"
  launch_type                        = "FARGATE"
  cluster                            = aws_ecs_cluster.app_cluster.id
  depends_on = [
    aws_iam_role_policy.app_ecs_service_role_policy,
    aws_iam_role_policy.app_ecs_execution_role_policy
  ]

  network_configuration {
    security_groups = flatten([var.security_groups_ids, aws_security_group.app_ecs_service.id])
    subnets = flatten(var.subnets_ids)
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.application_name
    container_port   = "80"
  }
}


/*====
Auto Scaling for ECS
======*/
resource "aws_iam_role" "app_ecs_autoscale_role" {
  name = "${var.application_name}_${var.environment}_ecs_autoscale_role"
  assume_role_policy = file("${path.module}/policies/ecs-autoscale-role.json")
}

resource "aws_iam_role_policy" "app_ecs_autoscale_role_policy" {
  name = "${var.application_name}_${var.environment}_ecs_autoscale_role_policy"
  policy = file("${path.module}/policies/ecs-autoscale-role-policy.json")
  role = aws_iam_role.app_ecs_autoscale_role.id
}

resource "aws_appautoscaling_target" "app_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.app_cluster.name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.app_ecs_autoscale_role.arn
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

resource "aws_appautoscaling_policy" "app_up" {
  name               = "${var.application_name}_${var.environment}_scale_up"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.app_cluster.name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"


  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.app_target]
}

resource "aws_appautoscaling_policy" "app_down" {
  name               = "${var.application_name}_${var.environment}_scale_down"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.app_cluster.name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.app_target]
}

/* metric used for auto scale */
resource "aws_cloudwatch_metric_alarm" "app_service_cpu_high" {
  alarm_name          = "${var.application_name}_${var.environment}_cpu_utilization_high_auto_scaling"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "85"

  dimensions = {
    ClusterName = aws_ecs_cluster.app_cluster.name
    ServiceName = aws_ecs_service.app.name
  }

  alarm_actions = [aws_appautoscaling_policy.app_up.arn]
  ok_actions = [aws_appautoscaling_policy.app_down.arn]
}

