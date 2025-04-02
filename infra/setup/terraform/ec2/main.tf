variable "ec2_instance_names" {
  description = "The names of the EC2 instances"
  type        = list(string)
}
variable "ec2_instance_ami" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}
variable "ec2_instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
}
variable "security_group_ids" {
  description = "The security group IDs to associate with the EC2 instances"
  type        = list(string)
}
variable "project_name" {
  description = "The name of the project"
  type        = string
}
variable "environment" {
  description = "The environment to use for the project"
  type        = string  
}
variable "key_name" {
  description = "The name of the key pair to use for the EC2 instances"
  type        = string
}
variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instances in"
}

variable "enable_public_ip" {
  description = "Whether to associate a public IP address with the EC2 instances"
  type        = bool
}


// EC2 Instances
resource "aws_instance" "ec2_instance_master" {
    ami           = var.ec2_instance_ami
    instance_type = var.ec2_instance_type
    security_groups = var.security_group_ids
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = var.enable_public_ip
    tags = {
        Name        = "${var.project_name}-master"
        Environment = var.environment
        ManagedBy   = "Terraform/setup - K8S cluster"
      }
}
resource "aws_instance" "ec2_instance_slave_1" {
    ami           = var.ec2_instance_ami
    instance_type = var.ec2_instance_type
    security_groups = var.security_group_ids
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = var.enable_public_ip
    tags = {
        Name        = "${var.project_name}-slave-1"
        Environment = var.environment
        ManagedBy   = "Terraform/setup - K8S cluster"
      }
}
resource "aws_instance" "ec2_instance_slave_2" {
    ami           = var.ec2_instance_ami
    instance_type = var.ec2_instance_type
    security_groups = var.security_group_ids
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = var.enable_public_ip
    tags = {
        Name        = "${var.project_name}-slave-2"
        Environment = var.environment
        ManagedBy   = "Terraform/setup - K8S cluster"
      }
}

// Key Pair
resource "aws_key_pair" "instance_key_pair" {
    key_name   = var.key_name
    public_key = "" // TODO
    tags = {
        Name        = "${var.project_name}-key-pair"
        Environment = var.environment
        ManagedBy   = "Terraform/setup EC2 K8s Key Pair instance"
    }
}
