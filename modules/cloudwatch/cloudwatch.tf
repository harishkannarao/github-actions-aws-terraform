data "template_file" "cloudwatch_dashboard_source" {
  template = "${file("${path.module}/dashboard/dashboard.json")}"

  vars = {
    application_name = var.application_name
    environment = var.environment
  }
}

resource "aws_cloudwatch_dashboard" "app-dashboard" {
  dashboard_name = "dashboard-${var.application_name}-${var.environment}"

  dashboard_body = data.template_file.cloudwatch_dashboard_source.rendered
}

resource "aws_cloudwatch_log_metric_filter" "yada" {
  name           = "AppErrorEventCountFilter"
  pattern        = "- \"ACCESS_LOG\" \"ERROR\""
  log_group_name = "${var.application_name}-${var.environment}"

  metric_transformation {
    name      = "AppErrorEventCount"
    namespace = "${var.application_name}/${var.environment}"
    value     = "1"
    default_value = "0"
  }
}

data "template_file" "alarm_topic_source" {
  template = "${file("${path.module}/topic/http-delivery.json")}"
}

resource "aws_sns_topic" "alarm_topic" {
  name = "alarms-topic"
  delivery_policy = data.template_file.alarm_topic_source.rendered
}

resource "aws_cloudwatch_metric_alarm" "docker_http_app_service_cpu_high" {
  alarm_name          = "${var.application_name}_${var.environment}_cpu_utilization_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "20"

  dimensions = {
    ClusterName = "${var.application_name}-${var.environment}-ecs-cluster"
    ServiceName = "${var.application_name}-${var.environment}"
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "docker_http_app_error_count_high" {
  alarm_name          = "${var.application_name}_${var.environment}_app_error_count_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AppErrorEventCount"
  namespace           = "${var.application_name}/${var.environment}"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "6"
  treat_missing_data  = "breaching"

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
  insufficient_data_actions = [aws_sns_topic.alarm_topic.arn]
}