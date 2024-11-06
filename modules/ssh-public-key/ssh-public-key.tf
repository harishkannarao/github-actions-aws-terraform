data "aws_secretsmanager_secret" "ssh_public_key" {
  name = "ssh-key-${var.environment}"
}

data "aws_secretsmanager_secret_version" "ssh_public_key_version" {
  secret_id = data.aws_secretsmanager_secret.ssh_public_key.id
}