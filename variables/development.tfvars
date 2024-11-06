region = "eu-west-2"
vpc_cidr_block = "10.0.0.0/16"
vpc_subnet_block = [
    {
        "availablity_zone": "eu-west-2a",
        "public_subnet_cidr": "10.0.1.0/24",
        "private_subnet_cidr": "10.0.10.0/24"
    },
    {
        "availablity_zone": "eu-west-2b",
        "public_subnet_cidr": "10.0.2.0/24",
        "private_subnet_cidr": "10.0.20.0/24"
    },
    {
        "availablity_zone": "eu-west-2c",
        "public_subnet_cidr": "10.0.3.0/24",
        "private_subnet_cidr": "10.0.30.0/24"
    }
]
environment = "development"
image_tag = "development"
application_name = "docker-http-app"
secruity_rest_api_app_name = "spring-security-rest-api"
secruity_rest_api_image_tag = "development"
acm_cert_domain = "harishkannarao.com"
min_capacity = "2"
max_capacity = "3"
third_party_ping_url = "http://www.example.org"
third_party_proxy_url = "https://private-development.harishkannarao.com/spring-security-rest-api/general-data"
database_multi_az = false
log_retention_in_days = 180
app_cors_origins = "http://localhost:8180,https://docker-http-app-development.harishkannarao.com:443,https://docker-http-app-development.harishkannarao.com,https://http-web-development.harishkannarao.com"
app_openapi_url = "https://docker-http-app-development.harishkannarao.com"
www_domain_name = "http-web-development"
www_cloudfront_alias = "http-web-development.harishkannarao.com"
ssh_key_pair_name = "ssh-key-development"
database_name = "development_db"
database_username = "development_db_user"
public_alb_path_mappings = {}
private_alb_path_mappings = {
    "sb-sec-rest" : {
        "priority" : 10,
        "path_pattern" : "/spring-security-rest-api/*",
        "port" : 80,
        "protocol" : "HTTP",
        "health_check_path" : "/spring-security-rest-api/general-data",
    },
}
# make bastion_ingress_cidr_blocks = [] to disable public access of bastion
bastion_ingress_cidr_blocks = ["0.0.0.0/0"]