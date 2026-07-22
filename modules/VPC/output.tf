output "subnet_id" {
  value       = aws_subnet.main.id
  description = "The Subnet which my EC2 will be created"
}