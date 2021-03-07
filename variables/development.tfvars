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
database_multi_az = false
log_retention_in_days = 180
app_cors_origins = "http://localhost:8180,https://docker-http-app-development.harishkannarao.com:443,https://docker-http-app-development.harishkannarao.com,https://http-web-development.harishkannarao.com"
app_openapi_url = "https://docker-http-app-development.harishkannarao.com"
www_domain_name = "http-web-development"
www_cloudfront_alias = "http-web-development.harishkannarao.com"
ssh_key_pair_name = "ssh-key-development"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfwUTDqW7ufy+DGulcDD8jfDQlfxs+Y6cy+JxnR2VUb8Jteg6NXKuFQcryMs6jPjH7jCNlLr/LMoCS2wyN8FVcfVoeVp/ZlzXJeeoON390npOHdhD39+Q4C3RXJjKf2+YHi2VuiR7m+nV246WRhSHYYVLeXHVL6t4FTyGLV7pWPWATcA15G8yS7zkJtU5Ryazu9VpfQwP2U5hMLCowL5uFGyU6p0iGM0EqVkv+CaSgYdidb2oOYWLioTZpjsHbJqw4GCoi0+CfxfuNZs3oDH1r4zAbpr1vbAEfUu7qC3ThqMIWbvrHmTkB8RF1zjKp5MS/6CR8GsxF539exHqM2wCR"