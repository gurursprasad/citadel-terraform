module "s3_storage" {
  source      = "../modules/storage"
  bucket_name = "test-1-gp-s3-bucket-1"
  env_name    = "staging"
}