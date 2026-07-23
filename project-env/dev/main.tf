terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }

  backend "s3" {
    bucket         = "suren2345"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terrafrom-lock"
  }
}

provider "aws" {
  region = local.region
}

locals {
  env         = "dev"
  region      = "ap-south-1"
  bucket_name = "suren-bucket-123"
}

module "VPC" {
  source = "../../modules/VPC"

  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  subnet_az   = "${locals.region}a"
  env         = locals.env
}

module "EC2" {
  source = "../../modules/EC2"

  ami_id        = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id     = module.VPC.subnet_id
  ec2_count     = 1
  env           = locals.env
}

module "S3" {
  source = "../../modules/S3"

  bucket_name = locals.bucket_name
}