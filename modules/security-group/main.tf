resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for Strapi EC2 instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

############################################
# Inbound Rules
############################################

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.this.id
  description       = "SSH access"
  cidr_ipv4         = var.ssh_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "strapi" {
  security_group_id = aws_security_group.this.id
  description       = "Strapi app"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 1337
  ip_protocol       = "tcp"
  to_port           = 1337
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.this.id
  description       = "HTTP"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

############################################
# Outbound Rule
############################################

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
