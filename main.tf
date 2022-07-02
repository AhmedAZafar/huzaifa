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
  region  = "eu-west-2"
  shared_config_files = [ "~/.aws/config" ]
  shared_credentials_files = [ "~/.aws/credentials" ]
  profile = "ahmed"
}

variable "cidr_block_vpc" {
  type = string
  default = "192.168.0.0/16"
}

variable "cidr_block_public_subnet" {
    type = string
    default = "192.168.34.0/24"
}

# resource "aws_vpc" "tf-vpc" {

#     cidr_block = var.cidr_block_vpc
#     instance_tenancy = "default"

#     tags = {
#       "name" = "tf-vpc"
#     }
# }

# resource "aws_subnet" "tf-vpc-public-subnet" {

#     vpc_id = aws_vpc.tf-vpc.id
#     cidr_block = var.cidr_block_public_subnet

#     tags = {
#       "name" = "tf-vpc-public-subnet"
#     }
  
# }

# resource "aws_internet_gateway" "tf-vpc-gateway" {
#     vpc_id = aws_vpc.tf-vpc.id
#     tags = {
#       "name" = "tf-vpc-igw"
#     }
# }

# resource "aws_route_table" "tf-vpc-rt" {
#     vpc_id = aws_vpc.tf-vpc.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.tf-vpc-gateway.id
#     }
# }

# resource "aws_route_table_association" "tf-public-subnet-rt-assoc" {
#     subnet_id = aws_subnet.tf-vpc-public-subnet.id
#     route_table_id = aws_route_table.tf-vpc-rt.id
  
# }

data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
  
}

resource "aws_network_interface" "tf-frontend-eni" {
    subnet_id = aws_subnet.tf-vpc-public-subnet.id
    private_ip = "192.168.34.70"
}

resource "aws_instance" "frontend-server" {

    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.large"

    network_interface {
          network_interface_id = aws_network_interface.tf-frontend-eni.id
          device_index         = 0
    }

    key_name = "huzaifa"
  
}



# resource "aws_instance" "app_server" {
#   ami           = "ami-830c94e3"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }
