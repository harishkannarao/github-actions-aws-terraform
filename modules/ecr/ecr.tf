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