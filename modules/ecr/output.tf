output "registry_id" {
  value = aws_ecr_repository.docker_http_app.registry_id
}

output "repository_url" {
  value = aws_ecr_repository.docker_http_app.repository_url
}