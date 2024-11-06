output "ssh_public_key" {
  value = data.aws_secretsmanager_secret_version.ssh_public_key_version.secret_string
}