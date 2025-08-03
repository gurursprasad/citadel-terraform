variable "env" {
  description = "The environment for which the IAM role is being created (e.g., dev, prod)."
  type        = string
  default     = "staging"
}

variable "role_name" {
  description = "The name of the IAM role to create for EC2 instances."
  type        = string
  default     = "instance_role"
  
}
