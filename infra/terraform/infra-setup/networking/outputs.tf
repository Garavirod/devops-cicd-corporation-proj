output "corporate_vpc_id" {
  description = "The ID of the Corporate VPC"
  value       = aws_vpc.vpc_corporate.id
}

output "corporate_public_subnets_ids" {
  description = "List of IDs of the Corporate Public Subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "corporate_private_subnets_ids" {
  description = "List of IDs of the Corporate Private Subnets"
  value       = aws_subnet.private_subnets[*].id
}
