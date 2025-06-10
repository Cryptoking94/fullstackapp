provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./modules/vpc"
  vpc_cidr   = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  db_subnets      = var.db_subnets
}

module "web" {
  source         = "./modules/web"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  ami_id         = var.web_ami_id
  instance_type  = var.web_instance_type
}

module "app" {
  source          = "./modules/app"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  ami_id          = var.app_ami_id
  instance_type   = var.app_instance_type
}

module "db" {
  source         = "./modules/db"
  vpc_id         = module.vpc.vpc_id
  db_subnets     = module.vpc.db_subnets
  db_username    = var.db_username
  db_password    = var.db_password
}
