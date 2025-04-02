module "networking" {
    source = "./networking"
    aws_vpc_cidr_block = "11.0.0.0/16"
    project_name = var.project_name
    public_subnets_cidrs = ["11.0.1.0/16", "11.0.2.0/16"]
    private_subnets_cidrs = ["11.0.3.0/16", "11.0.4.0/16"]
    availability_zones = var.availability_zone
}

module "security_groups" {
    source = "./security_groups"
    project_name = var.project_name
    environment = var.environment
}
