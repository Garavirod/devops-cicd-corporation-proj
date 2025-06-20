variable "ec2_instance_name" {
  description = "EC2 instance name"
  type        = string
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
variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instances in"
}
variable "enable_public_ip" {
  description = "Whether to associate a public IP address with the EC2 instances"
  type        = bool
}
variable "key_name" {
  description = "The name of the key pair to use for the EC2 instances"
  type        = string
}
variable "ebs_volume_size" {
  description = "value for the volume size in GB"
  type        = number
}
variable "ebs_volume_type" {
  description = "The type of volume to use for the EC2 instances"
  type        = string
}

// EC2 Instances
resource "aws_instance" "ec2_instance_k8s" {
    ami           = var.ec2_instance_ami
    instance_type = var.ec2_instance_type
    vpc_security_group_ids = var.security_group_ids
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = var.enable_public_ip
    root_block_device {
      volume_type = var.ebs_volume_type
      volume_size = var.ebs_volume_size
      delete_on_termination = true
    }
    tags = {
        Name = "${var.project_name}-${var.ec2_instance_name}-instance"
    }
    lifecycle {
      ignore_changes = [associate_public_ip_address] # To avoid delete and recreate the instance when ec2 state changes
    }
}
