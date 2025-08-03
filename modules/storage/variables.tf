variable "env" {
    description = "Environment name, e.g., dev, staging, prod"
    type        = string
}

variable "bucket_name" {
    description = "Name of the S3 bucket"
    type        = string
}