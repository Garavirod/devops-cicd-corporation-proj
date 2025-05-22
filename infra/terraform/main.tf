##############
# NETWORKING #
##############

module "networking" {
    source = "./networking"
    aws_vpc_cidr_block = "11.0.0.0/16"
    project_name = var.project_name
    public_subnets_cidrs = ["11.0.1.0/16", "11.0.2.0/16"]
    private_subnets_cidrs = ["11.0.3.0/16", "11.0.4.0/16"]
    availability_zones = var.availability_zone
}


#######
# EC2 #
#######

// EC2 Security Groups
module "security_groups" {
    source = "./security_groups"
    project_name = var.project_name
    environment = var.environment
}

// Key Pair

resource "aws_key_pair" "instance_key_pair" {
    key_name   = "k8s-instance-key-pair"
    public_key = file("../assets/ec2-keys/k8s-ec2-kp") # Path to your public key
    tags = {
        Name        = "${var.project_name}-key-pair"
        Environment = var.environment
        ManagedBy   = "Terraform/setup EC2 K8s Key Pair instance"
    }
}

// EC2 instances
module "ec2_master" {
  source = "./ec2"
  project_name = var.project_name
  environment = var.environment
  key_name = aws_key_pair.instance_key_pair.key_name
  subnet_id = module.networking.public_subnets_ids[0]
  ec2_instance_name = "master"
  ec2_instance_ami = "ami-084568db4383264d4" 
  ec2_instance_type = "t2.medium"
  security_group_ids = [aws_security_group.sg_ec2.id]
  enable_public_ip = true
}
module "ec2_slave_1" {
  source = "./ec2"
  project_name = var.project_name
  environment = var.environment
  key_name = aws_key_pair.instance_key_pair.key_name
  subnet_id = module.networking.public_subnets_ids[0]
  ec2_instance_name = "slave-1"
  ec2_instance_ami = "" 
  ec2_instance_type = ""
  security_group_ids = [aws_security_group.sg_ec2.id]
  enable_public_ip = true
}
module "ec2_slave_2" {
  source = "./ec2"
  project_name = var.project_name
  environment = var.environment
  key_name = aws_key_pair.instance_key_pair.key_name
  subnet_id = module.networking.public_subnets_ids[0]
  ec2_instance_name = "slave-2"
  ec2_instance_ami = "" 
  ec2_instance_type = ""
  security_group_ids = [aws_security_group.sg_ec2.id]
  enable_public_ip = true
}
