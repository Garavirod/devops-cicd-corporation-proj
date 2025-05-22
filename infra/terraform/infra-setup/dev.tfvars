# This file contains the variables for the dev environment. Do not set secret values or sensitive values in this file.

# Networking
availability_zones = [ 
  "us-east-1a",
  "us-east-1b",
]
public_subnets_cidrs = [ 
  "11.0.1.0/16", 
  "11.0.2.0/16"
]
private_subnets_cidrs = [  
  "11.0.3.0/16", 
  "11.0.4.0/16"
]

// EC2
ec2_k8s_instance_type = "t2.medium"
ec2_k8s_instance_ami = "ami-084568db4383264d4"
