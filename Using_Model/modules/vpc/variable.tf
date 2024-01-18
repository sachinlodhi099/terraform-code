variable "vpc_aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
  }

variable "vpc_cidr_block" {
  description = "AWS VPC CIDR block"
  type        = string
  }
variable "vpc_aws_cidr_subnets_public" {
  description = "AWS public subnet"
  type = list(string)
  }
variable "vpc_aws_cidr_subnets_private" {
  description = "AWS private subnet"
    type = list(string)
      }
variable "vpc_name_prefix" {
  description = "Name prefix"
    type        = string
    }

