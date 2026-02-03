# Fetch the latest Ubuntu 24.04 LTS (Noble) official server AMI
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"]   # Canonical's official owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    # This pattern matches the current standard storage-optimized images (gp3 volume)
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Get the default VPC (most accounts have one)
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC that are public (auto-assign public IP enabled)
data "aws_subnets" "default_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

locals {
  default_public_subnet_id = sort(data.aws_subnets.default_public.ids)[0]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.instance_name

  instance_type = var.instance_type
  subnet_id     = local.default_public_subnet_id
  ami           = data.aws_ami.ubuntu_24_04.id

  key_name      = "rushi_key"
  monitoring    = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}