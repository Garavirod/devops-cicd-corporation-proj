output "sg_ec2_k8s_id" {
  description = "Security group for K8s EC2 instances"
  value       = aws_security_group.sg_ec2_k8s.id  
}
