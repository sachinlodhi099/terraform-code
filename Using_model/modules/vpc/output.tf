output "vpc_id" {
  value =  aws_vpc.my_vpc.id
  }
output "vpc_public_subnet_id" {
  value =  aws_subnet.cluster-vpc-subnets-public.1
  }
 output "vpc_private_subnet_id" {
  value =  aws_subnet.cluster-vpc-subnets-private.1

  } 