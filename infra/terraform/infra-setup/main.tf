##############
# NETWORKING #
##############

module "networking" {
    source = "./networking"
    aws_vpc_cidr_block = var.vpc_cidr
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
module "ecs_k8s_security_groups" {
    source = "./security_groups"
    project_name = var.project_name
    environment = var.environment
    vpc_id = module.networking.corporate_vpc_id
}

// EC2 Key Pair
// This key pair is used to access the EC2 instances
resource "aws_key_pair" "instance_key_pair" {
    key_name   = "k8s-instance-key-pair"
    public_key = file("../../assets/ec2_k8s/key-paris/k8s-ec2-key-pair.pub")
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
  security_group_ids = [module.ecs_k8s_security_groups.sg_ec2_k8s_id]
  enable_public_ip = true
  ebs_volume_size = 25
  ebs_volume_type = "gp2"
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
  security_group_ids = [module.ecs_k8s_security_groups.sg_ec2_k8s_id]
  enable_public_ip = true
  ebs_volume_size = 25
  ebs_volume_type = "gp2"
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
  security_group_ids = [module.ecs_k8s_security_groups.sg_ec2_k8s_id]
  enable_public_ip = true
  ebs_volume_size = 25
  ebs_volume_type = "gp2"
}

// EC2 For Sonarqube
# module "ec2_sonarqube" {
#   source = "./ec2"
#   project_name = var.project_name
#   environment = var.environment
#   key_name = aws_key_pair.instance_key_pair.key_name
#   subnet_id = module.networking.corporate_public_subnets_ids[0]
#   ec2_instance_name = "sonarqube"
#   ec2_instance_ami = var.ec2_sonarqube_instance_ami
#   ec2_instance_type = var.ec2_sonarqube_instance_type
#   security_group_ids = [module.ecs_k8s_security_groups.sg_ec2_k8s_id]
#   enable_public_ip = true
#   ebs_volume_size = 20
#   ebs_volume_type = "gp2"
# }
// EC2 For Nexus
# module "ec2_nexus" {
#   source = "./ec2"
#   project_name = var.project_name
#   environment = var.environment
#   key_name = aws_key_pair.instance_key_pair.key_name
#   subnet_id = module.networking.corporate_public_subnets_ids[0]
#   ec2_instance_name = "nexus"
#   ec2_instance_ami = var.ec2_nexus_instance_ami
#   ec2_instance_type = var.ec2_nexus_instance_type
#   security_group_ids = [module.ecs_k8s_security_groups.sg_ec2_k8s_id]
#   enable_public_ip = true
#   ebs_volume_size = 20
#   ebs_volume_type = "gp2"
# }

// EC2 for jenkins
# module "ec2_jenkins" {
#   source = "./ec2"
#   project_name = var.project_name
#   environment = var.environment
#   key_name = aws_key_pair.instance_key_pair.key_name
#   subnet_id = module.networking.corporate_public_subnets_ids[0]
#   ec2_instance_name = "jenkins"
#   ec2_instance_ami = var.ec2_jenkins_instance_ami
#   ec2_instance_type = var.ec2_jenkins_instance_type
#   security_group_ids = [module.ecs_k8s_security_groups.sg_ec2_k8s_id]
#   enable_public_ip = true
#   ebs_volume_size = 30
#   ebs_volume_type = "gp2"
# }
