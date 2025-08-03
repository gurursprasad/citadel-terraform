# -----------------------------------------------------------------------------
# Outputs for Compute Module
# -----------------------------------------------------------------------------

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.this[*].id
}

output "instance_private_ips" {
  description = "List of private IP addresses of EC2 instances"
  value       = aws_instance.this[*].private_ip
}

output "instance_arns" {
  description = "List of EC2 instance ARNs"
  value       = aws_instance.this[*].arn
}

output "security_group_id" {
  description = "ID of the security group created for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

output "security_group_arn" {
  description = "ARN of the security group created for EC2 instances"
  value       = aws_security_group.ec2_sg.arn
}
