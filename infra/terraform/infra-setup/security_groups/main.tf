variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment to use for the project"
  type        = string
}



// EC2 Security Groups
resource "aws_security_group" "sg_ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.networking.vpc_id

  tags = {
    Name        = "${var.project_name}-ec2-sg"
    Environment = var.environment
    ManagedBy   = "Terraform/setup"
  }
}


