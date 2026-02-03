# --- VPC OUTPUTS ---

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.intern_task_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public-subnet.id
}

# --- EC2 INSTANCE 1 (Virginia) ---

output "virginia_server_public_ip" {
  description = "Public IP of the web server in Virginia"
  value       = aws_instance.web_server.public_ip
}

output "virginia_server_url" {
  description = "The URL to access your Hello World page"
  value       = "http://${aws_instance.web_server.public_ip}"
}

# --- EC2 INSTANCE 2 (Ohio) ---

output "ohio_server_public_ip" {
  description = "Public IP of the server in Ohio"
  value       = aws_instance.instance-2.public_ip
}

# --- SECURITY GROUPS ---

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.allow_web.id
}