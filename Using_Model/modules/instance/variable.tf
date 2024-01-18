variable "ec2_aws_region" {
description = "aws region"
type = string
}
variable "ec2_vpc_id" {
description = "aws vpc"
type = string
}
variable "ec2_public_ami" {
description = "aws public ami"
type = string
}
variable "ec2_private_ami" {
description = "aws public ami"
type = string
}
variable "ec2_vpc_id" {
description = "aws vpc id"
type = string
}       
variable "ec2_cidr_subnets_public" {
description = "aws subnet_id_public"
type = list(string)
}
variable "ec2_cidr_subnets_private" {
description = "aws subnet_id_public"
type = list(string)
}