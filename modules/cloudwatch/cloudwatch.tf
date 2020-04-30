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