# provider.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"   
    }
  }

  # we can store our state file remotely in s3 bucket for serious infra
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "ec2-project/terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "terraform-locks"   # optional for state locking
  #   encrypt        = true
  # }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Project     = "ec2-learning-task"
      Environment = "dev"
      Owner       = "Rushikesh"
    }
  }
}