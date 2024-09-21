output "ecr-registry-id" {
  value = module.ecr.registry_id
}

output "ecr-repository-url" {
  value = module.ecr.repository_url
}

output "alb-dns-name" {
  value = module.alb.alb_dns_name
}

output "private-alb-dns-name" {
  value = module.alb.private_alb_dns_name
}

output "alarm_topic_arn" {
  value = module.cloudwatch.alarm_topic_arn
}

output "www_distribution_domain_name" {
  value = module.cloudfront.www_distribution_domain_name
}