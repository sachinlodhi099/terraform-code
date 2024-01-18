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
   region = var.vpc_aws_region
 }

resource "aws_vpc" "my_vpc" {
      cidr_block = var.vpc_cidr_block
      instance_tenancy = "default"
      enable_dns_hostnames = true
 
      tags = {
        Name = "My-terraform-vpc"
        }
	}
data "aws_availability_zones" "available" {}


resource "aws_subnet" "cluster-vpc-subnets-public" {
    vpc_id            = aws_vpc.my_vpc.id
    count             = length(var.vpc_aws_cidr_subnets_public)
    availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))
    cidr_block        = element(var.vpc_aws_cidr_subnets_public, count.index)
    tags = {
	            Name = "${var.vpc_name_prefix}-public-subnet-${count.index}"
        }
	}

resource "aws_subnet" "cluster-vpc-subnets-private" {
    vpc_id            = aws_vpc.my_vpc.id
    count             = length(var.vpc_aws_cidr_subnets_private)
    availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))
    cidr_block        = element(var.vpc_aws_cidr_subnets_private, count.index)
    tags = {
                   Name = "${var.vpc_name_prefix}-private-subnet-${count.index}"
        }
	}


resource "aws_internet_gateway" "my_gate_way"{
     vpc_id = aws_vpc.my_vpc.id

     tags = {
	   Name = "my-terraform-igw"
          }
	  }


resource "aws_route_table" "terraform-public" {
     vpc_id = aws_vpc.my_vpc.id
     tags = {
             Name = "my-terraform-rt-public01"
          }
          }

resource "aws_route_table" "terraform-private" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
	 Name = "my-terraform-rt-private01"
	  }
	  }
resource "aws_route" "terrform-igw-route" {
    route_table_id            = aws_route_table.terraform-public.id
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id                =  aws_internet_gateway.my_gate_way.id
         }



resource "aws_route_table_association" "terraform-public" {
     count          = length(var.vpc_aws_cidr_subnets_public)
     subnet_id      = element(aws_subnet.cluster-vpc-subnets-public.*.id, count.index)
     route_table_id = aws_route_table.terraform-public.id
     }

resource "aws_route_table_association" "terraform-private" {
     count          = length(var.vpc_aws_cidr_subnets_private)
     subnet_id      = element(aws_subnet.cluster-vpc-subnets-private.*.id, count.index)
     route_table_id = aws_route_table.terraform-private.id
   }


