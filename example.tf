#--------------------------------------------------------------
# Instance
#--------------------------------------------------------------
resource "aws_instance" "main" {
    instance_type = "${var.aws_instance_type}"

    # AMI ID
    ami = "${var.aws_ami_id}"

    # This will create 1 instances
    count = 1

    subnet_id = "${aws_subnet.main.id}"
    security_groups = ["${aws_security_group.allow_all.id}"]
}

#--------------------------------------------------------------
# Security Group
#--------------------------------------------------------------
resource "aws_security_group" "inst_allow_http" {
  name = "inst_allow_http"
  description = "Allow all inbound traffic"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${var.public_cidr_block_1}","${var.public_cidr_block_2}"]
  }
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr_block}"
    enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_cidr_block_1}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_cidr_block_2}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_cidr_block_1}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_cidr_block_2}"
    map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "r" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
}

resource "aws_main_route_table_association" "a" {
    vpc_id = "${aws_vpc.main.id}"
    route_table_id = "${aws_route_table.r.id}"
}
