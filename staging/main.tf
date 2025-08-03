provider "aws" {
    region = "us-west-2"
}

module "iam" {
  source    = "../modules/iam"
  env       = "staging"
  role_name = "readonly"
}

module "s3_storage" {
  source      = "../modules/storage"
  env         = "staging"
  bucket_name = "gp"
}

module "vpc" {
    source = "../modules/vpc"

    env                = "staging"
    vpc_cidr_block     = "10.0.0.0/16"
    private_subnets   = ["10.0.0.0/19", "10.0.32.0/19"]
    public_subnets    = ["10.0.64.0/19", "10.0.96.0/19"]
    azs                = ["us-west-2a", "us-west-2b"]
    
}

module "compute" {
    source = "../modules/compute"

    env                = "staging"
    vpc_id             = module.vpc.vpc_id
    vpc_cidr_block     = "10.0.0.0/16"
    private_subnet_ids = module.vpc.private_subnets
    
    instance_count     = 1
    instance_type      = "t3.micro"
    key_name           = "new-qa-key"

    iam_instance_profile = module.iam.instance_profile_name
}
