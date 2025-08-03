variable "env" {
    description = "Environment name, e.g., dev, staging, prod"
    type        = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
    default = "10.0.0.0/16"
}

variable "azs" {
    description = "List of availability zones to use for the VPC"
    type        = list(string)
    # default     = ["us-west-2a", "us-west-2b"]
}

variable "private_subnets" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
}

variable "public_subnets" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
}

# variable "private_subnet_tags" {
#     description = "Tags for private subnets"
#     type        = map(any)
# }

# variable "public_subnet_tags" {
#     description = "Tags for public subnets"
#     type        = map(any)
# }

