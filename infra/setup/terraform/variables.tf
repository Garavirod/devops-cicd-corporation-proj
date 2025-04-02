variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "bookyland-corp"
}

variable "environment" {
  description = "The environment to use for the project"
  type        = string
}

// VPC
variable "availability_zone" {
  description = "The availability zone to use for the VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

// EC2 Instance

