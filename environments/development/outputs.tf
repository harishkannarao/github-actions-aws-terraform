output "ecr-registry-id" {
  value = module.ecs.registry_id
}

output "ecr-repository-url" {
  value = module.ecs.repository_url
}

output "alb-dns-name" {
  value = module.ecs.alb_dns_name
}

output "alarm_topic_arn" {
  value = module.cloudwatch.alarm_topic_arn
}

output "www_distribution_domain_name" {
  value = module.cloudfront.www_distribution_domain_name
}