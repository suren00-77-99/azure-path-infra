output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}