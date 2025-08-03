# -----------------------------------------------------------------------------
# Variables for Compute Module
# -----------------------------------------------------------------------------

variable "env" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where EC2 instances will be created"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC for security group rules"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where EC2 instances will be placed"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances (if empty, will use latest Amazon Linux 2)"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the AWS key pair for EC2 instances"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "IAM instance profile to attach to the EC2 instances"
  type        = string
  default     = ""
}