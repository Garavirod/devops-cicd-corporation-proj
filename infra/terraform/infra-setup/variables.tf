/* Input variables comes from CI/CD pipeline */

// Project name
// This variable is used to specify the name of the project for tagging resources
variable "project_name" {
  description = "The name of the project"
  type        = string
}

// Environment
// This variable is used to specify the environment (e.g., dev, prod) for tagging resources
variable "environment" {
  description = "The environment to use for the project"
  type        = string
}

// AWS region
// This variable is used to specify the AWS region where resources will be created
variable "aws_region" {
  description = "The AWS region to use for the project"
  type        = string  
}

/* Networking */

// VPC

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

// This variable is used to specify the CIDR block for the VPC where applications will be deployed
variable "availability_zones" {
  description = "The availability zone to use for the VPC"
  type        = list(string)
}

// Public subnets CIDR blocks
// This variable is used to specify the CIDR blocks for the public subnets in the VPC
variable "public_subnets_cidrs" {
  description = "The CIDR blocks for the public subnets in the VPC"
  type        = list(string)
}
// Private subnets CIDR blocks
// This variable is used to specify the CIDR blocks for the private subnets in the VPC
variable "private_subnets_cidrs" {
  description = "The CIDR blocks for the private subnets in the VPC"
  type        = list(string)
}

/* EC2 */

// EC2 instance type
// This variable is used to specify the instance type for the EC2 instances
variable "ec2_k8s_instance_type" {
  description = "The name of the EC2 instance type"
  type        = string
}

// EC2 instance AMI
// This variable is used to specify the AMI ID for the EC2 instances
variable "ec2_k8s_instance_ami" {
  description = "The name of the EC2 instance AMI"
  type        = string
}
