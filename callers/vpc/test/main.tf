terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "huzaifa-tf-backend"
    region = "eu-west-2"
    key = "test/terraform.tfstate"
    # dynamodb_table = "huzaifa-tf-backend-lock"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-2"
  # shared_config_files = [ "~/.aws/config" ]
  # shared_credentials_files = [ "~/.aws/credentials" ]
  profile = "default"
}

module "test_vpc_module" {
    source = "../../../modules/vpc"

    vpc_cidr_block = "10.11.0.0/16"
    vpc_instance_tenancy = "default"
    vpc_tag_name = "Module VPC"


    subnet_public_cidr_block = "10.11.1.0/24"
    subnet_tag_name = "Public Subnet"

    rt_cidr_public = "0.0.0.0/0"
    igw_tag_name = "Public IGW"

    my_private_ip = "192.168.34.70"
}

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

module "test_frontend_ec2_module" {

  source = "../../../modules/ec2"

  ec2_base_ami_id = data.aws_ami.ubuntu.id
  ec2_device_index  = "0"
  ec2_instance_type = "t2.micro"
  ec2_key_name = "huzaifa"
  ec2_eni_id = module.test_vpc_module.module_eni_id

  
}

