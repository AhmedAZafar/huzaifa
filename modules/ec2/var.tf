variable "ec2_base_ami_id" {
    type = string
    description = "Base AMI ID from AWS Ubuntu AMIs"
}

variable "ec2_instance_type" {
    type = string
    description = "Instance family of the EC2"
}

variable "ec2_eni_id" {
    type = string
    description = "Value retrieved after ENI is created - Use terrafrom export from ENI Module"
}

variable "ec2_device_index" {
    type = string
    description = "EC2 device Index for ENI"
    default = "0"
}

variable "ec2_key_name" {
    type = string
    description = "The Key pair used for SSH into instance"
    default = "huzaifa"
}