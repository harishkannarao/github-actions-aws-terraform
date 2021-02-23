/*====
Get latest AWS certificate for the domain
======*/
data "aws_acm_certificate" "default" {
  domain      = var.acm_cert_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

/*====
Cloudwatch Log Group
======*/
resource "aws_cloudwatch_log_group" "docker_http_app" {
  name = "${var.application_name}-${var.environment}"
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

resource "aws_iam_role" "docker_http_app_ecs_role" {
  name               = "${var.application_name}_${var.environment}_ecs_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

/* ecs service scheduler role */
resource "aws_iam_role_policy" "docker_http_app_ecs_service_role_policy" {
  name   = "${var.application_name}_${var.environment}_ecs_service_role_policy"
  policy = file("${path.module}/policies/ecs-service-role.json")
  role   = aws_iam_role.docker_http_app_ecs_role.id
}

/* role that the Amazon ECS container agent and the Docker daemon can assume */
resource "aws_iam_role" "docker_http_app_ecs_execution_role" {
  name               = "${var.application_name}_${var.environment}_ecs_task_execution_role"
  assume_role_policy = file("${path.module}/policies/ecs-task-execution-role.json")
}

resource "aws_iam_role_policy" "docker_http_app_ecs_execution_role_policy" {
  name   = "${var.application_name}_${var.environment}_ecs_execution_role_policy"
  policy = file("${path.module}/policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.docker_http_app_ecs_execution_role.id
}

/*====
App Load Balancer
======*/

resource "aws_alb_target_group" "docker_http_app_alb_target_group" {
  name     = "${var.application_name}-${var.environment}-atg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 3    
    timeout             = 5    
    interval            = 30    
    path                = "/health-check"    
    protocol            = "HTTP"
    matcher             = "200-299"  
  }
}

/* security group for ALB */
resource "aws_security_group" "docker_http_app_inbound_sg" {
  name        = "${var.application_name}-${var.environment}-inbound-sg"
  description = "Allow HTTP from Anywhere into ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}-${var.environment}-inbound-sg"
  }
}

resource "aws_alb" "docker_http_app" {
  name            = "${var.application_name}-${var.environment}-alb"
  subnets         = flatten(var.public_subnet_ids)
  security_groups = flatten([var.security_groups_ids, aws_security_group.docker_http_app_inbound_sg.id, aws_security_group.docker_http_app_ecs_service.id])

  tags = {
    Name        = "${var.application_name}-${var.environment}-alb"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "docker_http_app" {
  load_balancer_arn = aws_alb.docker_http_app.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.docker_http_app_alb_target_group]

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "docker_http_app_ssl" {
  load_balancer_arn = aws_alb.docker_http_app.arn
  port              = "443"
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.docker_http_app_alb_target_group]
  certificate_arn   = data.aws_acm_certificate.default.arn

  default_action {
    target_group_arn = aws_alb_target_group.docker_http_app_alb_target_group.arn
    type             = "forward"
  }
}

/*====
ECR repository to store our Docker images
======*/
resource "aws_ecr_repository" "docker_http_app" {
  name = var.repository_name
}

resource "aws_ecr_lifecycle_policy" "docker_http_app_policy" {
  repository = aws_ecr_repository.docker_http_app.name
  policy = file("${path.module}/policies/ecr-lifecycle-policy.json")
}

/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "docker_http_app_cluster" {
  name = "${var.application_name}-${var.environment}-ecs-cluster"
}

/*====
ECS task definitions
======*/

/* the task definition for the docker_http_app service */
data "template_file" "docker_http_app_task" {
  template = file("${path.module}/tasks/docker_http_app_task_definition.json")

  vars = {
    image           = "${aws_ecr_repository.docker_http_app.repository_url}:${var.image_tag}"
    region          = var.region
    database_url    = "jdbc:postgresql://${var.database_endpoint}:5432/${var.database_name}"
    database_username = var.database_username
    database_password = var.database_password
    third_party_ping_url = var.third_party_ping_url
    log_group       = aws_cloudwatch_log_group.docker_http_app.name
    ssh_public_key  = var.ssh_public_key
    app_openapi_url = var.app_openapi_url
    app_cors_origins = var.app_cors_origins
  }
}

resource "aws_ecs_task_definition" "docker_http_app" {
  family                   = "${var.application_name}_${var.environment}"
  container_definitions    = data.template_file.docker_http_app_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.docker_http_app_ecs_execution_role.arn
  task_role_arn            = aws_iam_role.docker_http_app_ecs_execution_role.arn
}



/*====
ECS service
======*/

/* Security Group for ECS */
resource "aws_security_group" "docker_http_app_ecs_service" {
  vpc_id      = var.vpc_id
  name        = "${var.environment}-ecs-service-sg"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-ecs-service-sg"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "docker_http_app" {
  name            = "${var.application_name}-${var.environment}"
  task_definition = aws_ecs_task_definition.docker_http_app.family
  desired_count   = var.min_capacity
  deployment_maximum_percent = "200"
  deployment_minimum_healthy_percent = "50"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.docker_http_app_cluster.id
  depends_on      = [aws_iam_role_policy.docker_http_app_ecs_service_role_policy, aws_alb_target_group.docker_http_app_alb_target_group]

  network_configuration {
    security_groups = flatten([var.security_groups_ids, aws_security_group.docker_http_app_ecs_service.id])
    subnets         = flatten(var.subnets_ids)
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.docker_http_app_alb_target_group.arn
    container_name   = "web"
    container_port   = "80"
  }
}


/*====
Auto Scaling for ECS
======*/
resource "aws_iam_role" "docker_http_app_ecs_autoscale_role" {
  name               = "${var.application_name}_${var.environment}_ecs_autoscale_role"
  assume_role_policy = file("${path.module}/policies/ecs-autoscale-role.json")
}

resource "aws_iam_role_policy" "docker_http_app_ecs_autoscale_role_policy" {
  name   = "${var.application_name}_${var.environment}_ecs_autoscale_role_policy"
  policy = file("${path.module}/policies/ecs-autoscale-role-policy.json")
  role   = aws_iam_role.docker_http_app_ecs_autoscale_role.id
}

resource "aws_appautoscaling_target" "docker_http_app_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.docker_http_app_cluster.name}/${aws_ecs_service.docker_http_app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.docker_http_app_ecs_autoscale_role.arn
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

resource "aws_appautoscaling_policy" "docker_http_app_up" {
  name                    = "${var.application_name}_${var.environment}_scale_up"
  service_namespace       = "ecs"
  resource_id             = "service/${aws_ecs_cluster.docker_http_app_cluster.name}/${aws_ecs_service.docker_http_app.name}"
  scalable_dimension      = "ecs:service:DesiredCount"


  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment = 1
    }
  }

  depends_on = [aws_appautoscaling_target.docker_http_app_target]
}

resource "aws_appautoscaling_policy" "docker_http_app_down" {
  name                    = "${var.application_name}_${var.environment}_scale_down"
  service_namespace       = "ecs"
  resource_id             = "service/${aws_ecs_cluster.docker_http_app_cluster.name}/${aws_ecs_service.docker_http_app.name}"
  scalable_dimension      = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment = -1
    }
  }

  depends_on = [aws_appautoscaling_target.docker_http_app_target]
}

/* metric used for auto scale */
resource "aws_cloudwatch_metric_alarm" "docker_http_app_service_cpu_high" {
  alarm_name          = "${var.application_name}_${var.environment}_cpu_utilization_high_auto_scaling"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "85"

  dimensions = {
    ClusterName = aws_ecs_cluster.docker_http_app_cluster.name
    ServiceName = aws_ecs_service.docker_http_app.name
  }

  alarm_actions = [aws_appautoscaling_policy.docker_http_app_up.arn]
  ok_actions    = [aws_appautoscaling_policy.docker_http_app_down.arn]
}

