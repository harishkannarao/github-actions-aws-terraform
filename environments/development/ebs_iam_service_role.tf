data "aws_iam_role" "ebs_iam_service_role" {
  name = "AWSServiceRoleForElasticBeanstalk"
}

data "aws_vpc" "test_vpc_data" {
  tags = {
    Name        = "${var.environment}-vpc"
  }
}