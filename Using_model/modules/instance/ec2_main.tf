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
  region = var.ec2_aws_region
  }


resource "aws_security_group" "bastion-sg" {
  name        = "T_bastion-sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.ec2_vpc_id

  ingress {
   description      = "all trafic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   // ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }


  egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
  // ipv6_cidr_blocks = ["::/0"]
     }

  tags = {
   Name = "terraform_bastion_sg"
        }
	}

    resource "aws_security_group" "Private-sg" {
  name        = "T_private-sg"
  description = "private security proup "
  vpc_id      = var.ec2_vpc_id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion-sg.id]

  }
  dynamic "ingress" {
    for_each = [80,8080,443,9090,9000]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }




  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "terraform_private_sg"
  }
}

resource "aws_instance" "web" {
  ami = var.ec2_public_ami
  instance_type = "t3.micro"

  subnet_id  = var.ec2_cidr_subnets_public
  associate_public_ip_address  = true
  key_name = "key-01"
  count = 1
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    Name = "MY_Terrafom_Instance-bastion-${count.index}"
  }
}

resource "aws_instance" "slave" {
  ami = var.ec2_private_ami
  instance_type = "t3.micro"

  subnet_id  = var.ec2_cidr_subnets_private
  associate_public_ip_address  = false
  key_name = "key-01"
  count = 2
  vpc_security_group_ids = [aws_security_group.Private-sg.id]

  tags = {
    Name = "MY_Terrafom_Instance-private-${count.index}"
  }
  lifecycle {
        ignore_changes = [tags,instance_type]

}
}

