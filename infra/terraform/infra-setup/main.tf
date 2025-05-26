##############
# NETWORKING #
##############

module "networking" {
    source = "./networking"
    aws_vpc_cidr_block = "11.0.0.0/16"
    project_name = var.project_name
    public_subnets_cidrs = var.public_subnets_cidrs
    private_subnets_cidrs = var.private_subnets_cidrs
    availability_zones = var.availability_zones
}


#######
# EC2 #
#######

// EC2 Security Groups
// This module creates security groups for the EC2 instances
module "security_groups" {
    source = "./security_groups"
    project_name = var.project_name
    environment = var.environment
    vpc_id = module.networking.corporate_vpc_id
}

// EC2 Key Pair
// This key pair is used to access the EC2 instances
resource "aws_key_pair" "instance_key_pair" {
    key_name   = "k8s-instance-key-pair"
    public_key = file("../../assets/ec2-keys/k8s-ec2-key-pair.pub") # Path to your public key
    tags = {
      Name     = "${var.project_name}-k8s-key-pair"
    }
}

// EC2 instances
// This module creates EC2 instances for the Kubernetes cluster
module "ec2_master" {
  source = "./ec2"
  project_name = var.project_name
  environment = var.environment
  key_name = aws_key_pair.instance_key_pair.key_name
  subnet_id = module.networking.corporate_public_subnets_ids[0]
  ec2_instance_name = "master"
  ec2_instance_ami = var.ec2_k8s_instance_ami
  ec2_instance_type = var.ec2_k8s_instance_type
  security_group_ids = [module.security_groups.sg_ec2_k8s.id]
  enable_public_ip = true
}
module "ec2_slave_1" {
  source = "./ec2"
  project_name = var.project_name
  environment = var.environment
  key_name = aws_key_pair.instance_key_pair.key_name
  subnet_id = module.networking.corporate_public_subnets_ids[0]
  ec2_instance_name = "slave-1"
  ec2_instance_ami = var.ec2_k8s_instance_ami
  ec2_instance_type = var.ec2_k8s_instance_type
  security_group_ids = [module.security_groups.sg_ec2_k8s.id]
  enable_public_ip = true
}
module "ec2_slave_2" {
  source = "./ec2"
  project_name = var.project_name
  environment = var.environment
  key_name = aws_key_pair.instance_key_pair.key_name
  subnet_id = module.networking.corporate_public_subnets_ids[0]
  ec2_instance_name = "slave-2"
  ec2_instance_ami = var.ec2_k8s_instance_ami
  ec2_instance_type = var.ec2_k8s_instance_type
  security_group_ids = [module.security_groups.sg_ec2_k8s.id]
  enable_public_ip = true
}
