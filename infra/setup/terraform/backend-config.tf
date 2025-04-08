terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }
  backend "s3" {
    
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Name        = "${var.project_name}-bookyland-corp"
      Environment = var.environment
      ManagedBy   = "Terraform/setup"
    }
  }
  
}

