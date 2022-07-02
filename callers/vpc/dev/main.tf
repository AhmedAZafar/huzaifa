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


module "dev1_vpc_module" {
    source = "../../../modules/vpc"

    vpc_cidr_block = "10.10.0.0/16"
    vpc_instance_tenancy = "default"
    vpc_tag_name = "Module VPC"


    subnet_public_cidr_block = "10.10.1.0/24"
    subnet_tag_name = "Public Subnet"

    rt_cidr_public = "0.0.0.0/0"
    igw_tag_name = "Public IGW"
}


module "dev2_vpc_module" {
    source = "../../../modules/vpc"

    vpc_cidr_block = "10.11.0.0/16"
    vpc_instance_tenancy = "default"
    vpc_tag_name = "Module VPC"


    subnet_public_cidr_block = "10.11.1.0/24"
    subnet_tag_name = "Public Subnet"

    rt_cidr_public = "0.0.0.0/0"
    igw_tag_name = "Public IGW"
}


module "dev3_vpc_module" {
    source = "../../../modules/vpc"

    vpc_cidr_block = "10.12.0.0/16"
    vpc_instance_tenancy = "default"
    vpc_tag_name = "Module VPC"


    subnet_public_cidr_block = "10.12.1.0/24"
    subnet_tag_name = "Public Subnet"

    rt_cidr_public = "0.0.0.0/0"
    igw_tag_name = "Public IGW"
}