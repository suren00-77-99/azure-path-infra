terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "suren2345"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terrafrom-lock"
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  # VPC
  vpc_name      = "dev-vpc"
  vpc_cidr      = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
  az            = "ap-south-1a"

  # EC2
  ami             = "ami-0f58b397bc5c1f2e8" 
  instance_type   = "t2.micro"
  key_name        = "my-key"
  instance_name   = "dev-server"
  sg_name         = "dev-sg"

  # S3
  bucket_name = "suren-demo-bucket-12345"
}

module "VPC" {
  source = "../../module/VPC"
  vpc_name      = locals.vpc_name
  vpc_cidr      = locals.vpc_cidr
  public_subnet = locals.public_subnet
  az            = locals.az
  env           = "dev"

}

module "EC2" {
  source = "../../module/EC2"
  ami             = locals.ami
  instance_type   = locals.instance_type
  subnet_id       = module.vpc.subnet_id
  instance_name   = locals.instance_name
  count           = 2
  env           = "dev"
}

module "S3" {
  source = "../../module/S3"
  bucket_name = locals.bucket_name
}