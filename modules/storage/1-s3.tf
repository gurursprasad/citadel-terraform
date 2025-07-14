resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.bucket_name}-s3-bucket"
    Environment = var.env_name
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "echo 'Bucket Name: ${aws_s3_bucket.this.bucket}'"
  }
}
