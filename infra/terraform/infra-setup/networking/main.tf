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
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets_cidrs)
  vpc_id = aws_vpc.corp_vpc.id
  cidr_block = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "${var.project_name}-private-subnet-${count.index}"
  }
}

// Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.corp_vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

// Public route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.corp_vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

// Private route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.corp_vpc.id
  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

// Route Table Associations
resource "aws_route_table_association" "public_rt_association" {
  count = length(var.public_subnets_cidrs)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association" {
  count = length(var.private_subnets_cidrs)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

 