variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
      }

variable "cidr_block" {
  description = "AWS VPC CIDR block"
  type        = string
	  }
variable "name_prefix" {
  description = "Name prefix"
    type        = string
    }
variable "aws_cidr_subnets_public" {
  description = "AWS public subnet list"
    type        = list(string)
    }
variable "aws_cidr_subnets_private" {
  description = "AWS private subnet list"
    type        = list(string)
    }

variable "aws_public_ami" {
  description = "AWS private subnet list"
    type        = string
    }
variable "aws_private_ami" {
  description = "AWS private subnet list"
    type        = string
    }

