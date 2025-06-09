# This file contains the variables for the dev environment. Do not set secret values or sensitive values in this file.

##############
# Networking # 
##############

// VPC AZ's
availability_zones = [ 
  "us-east-1a",
  "us-east-1b",
]
// VPC CIDR
vpc_cidr = "11.0.0.0/16"

// Subnets CIDRs
public_subnets_cidrs = [ 
  "11.0.1.0/24", // 11.0.1.0 to 11.0.1.255
  "11.0.2.0/24" // 11.0.2.0 to 11.0.2.255
]
private_subnets_cidrs = [  
  "11.0.3.0/24",  // 11.0.3.0 to 11.0.3.255
  "11.0.4.0/24" // 11.0.4.0 to 11.0.4.255
]

#######
# EC2 #
#######

// Kubernetes cluster
ec2_k8s_instance_type = "t2.medium"
ec2_k8s_instance_ami = "ami-084568db4383264d4"

// Jenkins
ec2_jenkins_instance_type = "t2.medium" 
ec2_jenkins_instance_ami = "ami-084568db4383264d4"
// Nexus
ec2_nexus_instance_type = "t2.medium"
ec2_nexus_instance_ami = "ami-084568db4383264d4"
// SonarQube
ec2_sonarqube_instance_type = "t2.medium" 
ec2_sonarqube_instance_ami = "ami-084568db4383264d4"
