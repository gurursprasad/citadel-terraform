# iam module outputs
output "iam_role_name" {
  description = "Name of the IAM role"
  value       = module.iam.name
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = module.iam.instance_profile_name
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.iam.role_arn
}

# s3 storage module outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3_storage.bucket_name
}

# vpc module outputs
output "vpc_id" {
    description = "The ID of the VPC"
    value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnets
}

# Compute module outputs
output "ec2_instance_ids" {
  description = "List of EC2 instance IDs"
  value       = module.compute.instance_ids
}

output "ec2_instance_private_ips" {
  description = "List of private IP addresses of EC2 instances"
  value       = module.compute.instance_private_ips
}

output "ec2_security_group_id" {
  description = "ID of the security group for EC2 instances"
  value       = module.compute.security_group_id
}
