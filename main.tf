terraform {
  required_version = ">= 0.12"
  required_providers {
    aws   = ">= 3.54.0"
    local = ">= 2.1.0"
  }
  backend "s3" {
    bucket  = "fullcycleterraformbucket"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "calebe-admin-icloud"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "calebe-admin-icloud"
}

module "new-vpc" {
  source         = "./modules/vpc"
  prefix         = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "eks" {
  source         = "./modules/eks"
  vpc_id         = module.new-vpc.vpc_id
  subnet_ids     = module.new-vpc.subnet_ids
  prefix         = var.prefix
  cluster_name   = var.cluster_name
  retention_days = var.retention_days
  desired_size   = var.desired_size
  max_size       = var.max_size
  min_size       = var.min_size
}