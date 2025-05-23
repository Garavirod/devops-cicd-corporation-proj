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
      ProjectName        = "${var.project_name}"
      Environment = var.environment
      ManagedBy   = "Terraform/setup"
    }
  }
}

