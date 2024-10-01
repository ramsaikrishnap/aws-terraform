output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_ip" {
  description = "Public IP of the NAT Gateway (if created)"
  value       = var.create_nat_gateway ? aws_eip.nat[0].public_ip : null
}
