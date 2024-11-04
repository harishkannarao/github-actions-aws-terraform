/*====
ECR repository to store our Docker images
======*/
resource "aws_ecr_repository" "app" {
  name = var.repository_name
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "app_policy" {
  repository = aws_ecr_repository.app.name
  policy = file("${path.module}/policies/ecr-lifecycle-policy.json")
}