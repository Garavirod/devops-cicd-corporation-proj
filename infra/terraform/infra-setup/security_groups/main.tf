variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment to use for the project"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to use for the security groups"
  type        = string 
}



// EC2 Security Groups
resource "aws_security_group" "sg_ec2_k8s" {
  name        = "${var.project_name}-ec2-k8s-sg"
  description = "Security group for K8s EC2 instances"
  vpc_id      = var.vpc_id
  tags = {
    Name      = "${var.project_name}-ec2-k8s-sg"
  }
}


