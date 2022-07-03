########## VPC VARS #########


variable "vpc_cidr_block" {
    type = string
}

variable "vpc_instance_tenancy" {
    type = string
}

variable "vpc_tag_name" {
    type = string
}


########## IGW VARS #########

variable "igw_tag_name" {
    type = string
}

########## SUBNET VARS #########

variable "subnet_public_cidr_block" {
    type = string
}

variable "subnet_tag_name" {
    type = string
}

########## RT VARS #########

variable "rt_cidr_public" {
    type = string
}


########## eni VARS #########

variable "my_private_ip" {
    type = string
  
}
