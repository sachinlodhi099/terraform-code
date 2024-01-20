terraform {
  required_providers {
          aws = {
	  source  = "hashicorp/aws"
          version = "~> 4.16"
    } 
    }
required_version = ">= 1.2.0"
    }
																				
provider "aws" {
	region     = var.aws_region		
	}	
data "aws_availability_zones" "available" {}

module "aws-vpc" {
  source = "./modules/vpc"
  vpc_aws_region = var.aws_region
  vpc_cidr_block = var.cidr_block
  vpc_aws_cidr_subnets_public = var.aws_cidr_subnets_public
  vpc_aws_cidr_subnets_private = var.aws_cidr_subnets_private
  vpc_name_prefix = var.name_prefix
 
}
module "aws-ec2" {
  source = "./modules/instance"
  ec2_aws_region = var.aws_region
  ec2_vpc_id = module.aws-vpc.vpc_id
  ec2_public_ami = var.aws_public_ami
  ec2_private_ami = var.aws_private_ami
  ec2_cidr_subnets_public = module.aws-vpc.vpc_public_subnet_id.id
  ec2_cidr_subnets_private =module.aws-vpc.vpc_private_subnet_id.id
  }

