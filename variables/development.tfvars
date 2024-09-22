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
acm_cert_domain = "harishkannarao.com"
min_capacity = "2"
max_capacity = "3"
third_party_ping_url = "http://www.example.org"
third_party_proxy_url = "https://private-development.harishkannarao.com"
database_multi_az = false
log_retention_in_days = 180
app_cors_origins = "http://localhost:8180,https://docker-http-app-development.harishkannarao.com:443,https://docker-http-app-development.harishkannarao.com,https://http-web-development.harishkannarao.com"
app_openapi_url = "https://docker-http-app-development.harishkannarao.com"
www_domain_name = "http-web-development"
www_cloudfront_alias = "http-web-development.harishkannarao.com"
ssh_key_pair_name = "ssh-key-development"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4UFSvLyIRKfAX+ha/v9jOMPph2ppCWs53pBC5I60sf6z5fjTYb8BKawYVMklQPbiWJ7NDL/CEFfQWEOP1XDYP9klqEHEpCcAfQSIQSMP/Q2KeqT8hq17DFGs8YMjAYGB+S+4kQnSipKvkjgDcshWTFAQF3pE1/lCbIf1ZVh48F8ZhKB1IjY1aLyXe1QHeRTUCWI2WbUrLP7SeSklCWMriN6gKWMoU+/oe3yFD6CLTz4vngK+B6qt6CCWyHi9wf1ATuAyzsaxCU2S3ITQmeXQNr/MJn1djIr+Ke3e/rvtHNMwXzFZuhsTAe6taa+AB+Lj4t5F4TzEf/e690f4bF8wP"
database_name='development_db'
database_username='development_db_user'