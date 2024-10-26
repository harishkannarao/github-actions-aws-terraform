module "alb" {
  source              = "../../modules/alb"
  application_name    = var.application_name
  environment         = var.environment
  acm_cert_domain     = var.acm_cert_domain
  vpc_id              = module.vpc.vpc_id
  public_alb_security_groups_ids = [
    module.bastion.bastion_sg_id
  ]
  private_alb_security_groups_ids = [
    module.bastion.bastion_sg_id
  ]
  subnets_ids         = module.vpc.private_subnets_id
  public_subnet_ids   = module.vpc.public_subnets_id
}