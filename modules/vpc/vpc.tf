resource "aws_vpc" "my_vpc" {

    cidr_block = "${var.vpc_cidr_block}"
    instance_tenancy = "${var.vpc_instance_tenancy}"

    tags = {
      "Name" = "${var.vpc_tag_name}"
    }
}


resource "aws_subnet" "my_subnet" {

    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "${var.subnet_public_cidr_block}"

    tags = {
      "name" = "${var.subnet_tag_name}"
    }
  
}

resource "aws_internet_gateway" "my_igw" {

    vpc_id = aws_vpc.my_vpc.id
    tags = {
      "name" = "${var.igw_tag_name}"
    }
}

resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "${var.rt_cidr_public}"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}

resource "aws_route_table_association" "my_rta" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id = aws_subnet.my_subnet.id
}