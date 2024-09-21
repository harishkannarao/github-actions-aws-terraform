/*====
Get latest AWS certificate for the domain
======*/
data "aws_acm_certificate" "default" {
  domain      = var.acm_cert_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

/*====
Public App Load Balancer
======*/

resource "aws_alb_target_group" "docker_http_app_alb_target_group" {
  name     = "${var.application_name}-${var.environment}-atg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 3    
    timeout             = 5    
    interval            = 30    
    path                = "/health-check"    
    protocol            = "HTTP"
    matcher             = "200-299"  
  }
}

/* security group for public ALB */
resource "aws_security_group" "docker_http_app_inbound_sg" {
  name        = "${var.application_name}-${var.environment}-inbound-sg"
  description = "Allow HTTP from Anywhere into public ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}-${var.environment}-inbound-sg"
  }
}

resource "aws_alb" "docker_http_app" {
  name            = "${var.application_name}-${var.environment}-alb"
  subnets         = flatten(var.public_subnet_ids)
  security_groups = flatten([var.public_alb_security_groups_ids, aws_security_group.docker_http_app_inbound_sg.id])

  tags = {
    Name        = "${var.application_name}-${var.environment}-alb"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "docker_http_app" {
  load_balancer_arn = aws_alb.docker_http_app.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.docker_http_app_alb_target_group]

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "docker_http_app_ssl" {
  load_balancer_arn = aws_alb.docker_http_app.arn
  port              = "443"
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.docker_http_app_alb_target_group]
  certificate_arn   = data.aws_acm_certificate.default.arn

  default_action {
    target_group_arn = aws_alb_target_group.docker_http_app_alb_target_group.arn
    type             = "forward"
  }
}

/*====
Private App Load Balancer
======*/

resource "aws_alb_target_group" "private_alb_target_group" {
  name     = "private-${var.environment}-atg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 3    
    timeout             = 5    
    interval            = 30    
    path                = "/health-check"    
    protocol            = "HTTP"
    matcher             = "200-299"  
  }
}

/* security group for private ALB */
resource "aws_security_group" "private_inbound_sg" {
  name        = "private-${var.environment}-inbound-sg"
  description = "Allow HTTP from Anywhere into private ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-${var.environment}-inbound-sg"
  }
}

resource "aws_alb" "private_alb" {
  name            = "private-${var.environment}-alb"
  subnets         = flatten(var.subnets_ids)
  internal        = true
  security_groups = flatten([var.private_alb_security_groups_ids, aws_security_group.private_inbound_sg.id])

  tags = {
    Name        = "private-${var.environment}-alb"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "private_alb_listener" {
  load_balancer_arn = aws_alb.private_alb.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.private_alb_target_group]

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "private_alb_listener_ssl" {
  load_balancer_arn = aws_alb.private_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.private_alb_target_group]
  certificate_arn   = data.aws_acm_certificate.default.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Success!!!"
      status_code  = "200"
    }
  }
}