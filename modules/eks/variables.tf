variable "env" {
  description = "The environment for the EKS cluster (e.g. dev, staging, prod)"
  type        = string
}

variable "eks_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs where EC2 instances will be placed"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be created"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC for security group rules"
  type        = string
}

