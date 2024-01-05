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
/*
variable "aws_avail_zones" {
  description = "AWS Availability Zones Used"
    type        = list(string)
}
*/
variable "aws_cidr_subnets_public" {
  description = "AWS public subnet list"
  type        = list(string)
}

variable "aws_cidr_subnets_private" {
  description = "AWS private subnet list"
  type        = list(string)
}
variable "ami_id" {
description = "aws ami id"
type = string
}

variable "instance_count" {
description = "instance count"
type = number
}

