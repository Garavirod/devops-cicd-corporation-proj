variable "aws_vpc_cidr_block" {
  type = string
  description = "CIDR block for the VPC"
}
variable "project_name" {
  type = string
  description = "The name of the project" 
}
variable "public_subnets_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for public subnets"
}
variable "private_subnets_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "availability_zones" {
  type = list(string)
  description = "List of availability zones to use for the subnets"
}

// VPC
resource "aws_vpc" "corp_vpc" {
  cidr_block = var.aws_vpc_cidr_block
  tags = {
    Name = "${var.project_name}-vpc"
    ManagedBy = "Terraform/setup - ${var.project_name}-vpc"
  }
}

// Subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidrs)
  vpc_id = aws_vpc.corp_vpc.id
  cidr_block = element(var.public_subnets_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "${var.project_name}-public-subnet-${count.index}"
    ManagedBy = "Terraform/setup - ${var.project_name}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets_cidrs)
  vpc_id = aws_vpc.corp_vpc.id
  cidr_block = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
    ManagedBy = "Terraform/setup - ${var.project_name}"
  }
}


