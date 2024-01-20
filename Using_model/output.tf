
output "my_vpc_id" {
   value =  module.aws-vpc.vpc_id
  }
output "public_subnet_id" {
   value =  module.aws-vpc.vpc_public_subnet_id.id
  }
output "private_subnet_id" {
   value =  module.aws-vpc.vpc_private_subnet_id.id
  }