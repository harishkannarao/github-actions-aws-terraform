data "template_file" "cloudwatch_dashboard_source" {
  template = file("${path.module}/dashboard/dashboard.json")

  vars = {
    application_name = var.application_name
    environment = var.environment
  }
}

resource "aws_cloudwatch_dashboard" "app-dashboard" {
  dashboard_name = "dashboard-${var.application_name}-${var.environment}"

  dashboard_body = data.template_file.cloudwatch_dashboard_source.rendered
}

resource "aws_cloudwatch_log_metric_filter" "app_error_event_count_filter" {
  name           = "AppErrorEventCountFilter"
  pattern        = "[date, time, logLevel=ERROR, message]"
  log_group_name = var.application_log_group_name

  metric_transformation {
    name      = "AppErrorEventCount"
    namespace = "${var.application_name}/${var.environment}"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_log_metric_filter" "app_runtime_exception_count_filter" {
  name           = "AppRuntimeExceptionCountFilter"
  pattern        = "- \"ACCESS_LOG\" \"RuntimeException\""
  log_group_name = var.application_log_group_name

  metric_transformation {
    name      = "AppRuntimeExceptionCount"
    namespace = "${var.application_name}/${var.environment}"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_log_metric_filter" "app_slow_response_count_filter" {
  name           = "AppSlowResponseCountFilter"
  pattern        = "[date, time, logLevel=ACCESS_LOG, resTime>=120000, byte, status, ip, reqId, method, url!=*health-check*]"
  log_group_name = var.application_log_group_name

  metric_transformation {
    name      = "AppSlowResponseCount"
    namespace = "${var.application_name}/${var.environment}"
    value     = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_log_metric_filter" "app_5XX_status_count_filter" {
  name           = "App5XXStatusCountFilter"
  pattern        = "[date, time, logLevel=ACCESS_LOG, resTime, byte, status>=500&&status<=599, ip, reqId, method, url]"
  log_group_name = var.application_log_group_name

  metric_transformation {
    name      = "App5XXStatusCount"
    namespace = "${var.application_name}/${var.environment}"
    value     = "1"
    default_value = "0"
  }
}

data "template_file" "alarm_topic_source" {
  template = file("${path.module}/topic/http-delivery.json")
}

resource "aws_sns_topic" "alarm_topic" {
  name = "alarms-topic"
  delivery_policy = data.template_file.alarm_topic_source.rendered
}

resource "aws_cloudwatch_metric_alarm" "app_service_cpu_high" {
  alarm_name          = "${var.application_name}_${var.environment}_ecs_cpu_utilization_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "80"

  dimensions = {
    ClusterName = var.application_ecs_cluster_name
    ServiceName = var.application_ecs_service_name
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_service_memory_high" {
  alarm_name          = "${var.application_name}_${var.environment}_ecs_memory_utilization_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "75"

  dimensions = {
    ClusterName = var.application_ecs_cluster_name
    ServiceName = var.application_ecs_service_name
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_service_task_count_low" {
  alarm_name          = "${var.application_name}_${var.environment}_ecs_task_count_low_notification"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "SampleCount"
  threshold           = var.ecs_min_task_count

  dimensions = {
    ClusterName = var.application_ecs_cluster_name
    ServiceName = var.application_ecs_service_name
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_rds_cpu_high" {
  alarm_name          = "${var.application_name}_${var.environment}_rds_cpu_utilization_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "80"

  dimensions = {
    DBInstanceIdentifier = var.rds_database_identifier
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_rds_storage_low" {
  alarm_name          = "${var.application_name}_${var.environment}_rds_storage_low_notification"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "1000000000"

  dimensions = {
    DBInstanceIdentifier = var.rds_database_identifier
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_error_count_high" {
  alarm_name          = "${var.application_name}_${var.environment}_app_error_count_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AppErrorEventCount"
  namespace           = "${var.application_name}/${var.environment}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "6"
  treat_missing_data  = "breaching"

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
  insufficient_data_actions = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_runtime_exception_count_high" {
  alarm_name          = "${var.application_name}_${var.environment}_app_runtime_exception_count_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AppRuntimeExceptionCount"
  namespace           = "${var.application_name}/${var.environment}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "6"
  treat_missing_data  = "breaching"

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
  insufficient_data_actions = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_slow_response_count_high" {
  alarm_name          = "${var.application_name}_${var.environment}_app_slow_response_count_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AppSlowResponseCount"
  namespace           = "${var.application_name}/${var.environment}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "6"
  treat_missing_data  = "breaching"

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
  insufficient_data_actions = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "app_5XX_status_count_high" {
  alarm_name          = "${var.application_name}_${var.environment}_app_5XX_status_count_high_notification"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "App5XXStatusCount"
  namespace           = "${var.application_name}/${var.environment}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "6"
  treat_missing_data  = "breaching"

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
  insufficient_data_actions = [aws_sns_topic.alarm_topic.arn]
}