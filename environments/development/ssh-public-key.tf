module "ssh-public-key" {
  source            = "../../modules/ssh-public-key"
  environment       = var.environment
}