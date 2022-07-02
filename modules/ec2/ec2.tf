


resource "aws_instance" "frontend-server" {

    ami = "${var.ec2_base_ami_id}"
    instance_type = "${var.ec2_instance_type}"

    network_interface {
          network_interface_id = "${var.ec2_eni_id}"
          device_index         = "${var.ec2_device_index}"
    }

    key_name = "${var.ec2_key_name}"
  
}
