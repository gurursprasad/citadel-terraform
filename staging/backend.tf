# resource "aws_s3_bucket" "tf_state" {
#   bucket = "tfstate-gp-s3-bucket" 

#   tags = {
#     Name        = "tfstate-gp-s3-bucket"
#     Environment = "staging-env"
#   }
# }

# resource "aws_s3_bucket_versioning" "tf_state_bucket_versioning" {
#   bucket = aws_s3_bucket.tf_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_dynamodb_table" "tf_lock" {
#   name             = "terraform-locks"
#   hash_key         = "LockID"
#   billing_mode     = "PAY_PER_REQUEST"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# terraform {
#   backend "s3" {
#     bucket       = "tfstate-gp-s3-bucket"
#     # dynamodb_table = "terraform-locks"
#     key          = "envs/dev/terraform.tfstate"
#     use_lockfile = true
#     region       = "us-west-2"
#   }
# }
