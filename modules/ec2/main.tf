resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id # Should be the private subnet ID
  key_name      = var.key_name

  # Changed to false for private subnet security
  associate_public_ip_address = false 

  # Use a list for security groups
  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data

  # Best practice: Add metadata options to require IMDSv2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${var.name}-ec2"
  }
}