# Internet VPC
resource "aws_vpc" "fs-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "fs-vpc"
    }
}
# Subnets
resource "aws_subnet" "fs-subnet-public-1" {
    vpc_id = "${aws_vpc.fs-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_SB_REGION.av-a}"

    tags = {
        Name = "fs-subnet-public-1"
    }
}
resource "aws_subnet" "fs-subnet-public-2" {
    vpc_id = "${aws_vpc.fs-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_SB_REGION.av-b}"

    tags = {
        Name = "fs-subnet-public-2"
    }
}
resource "aws_subnet" "fs-subnet-private-1" {
    vpc_id = "${aws_vpc.fs-vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_SB_REGION.av-a}"

    tags = {
        Name = "fs-subnet-private-1"
    }
}
resource "aws_subnet" "fs-subnet-private-2" {
    vpc_id = "${aws_vpc.fs-vpc.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_SB_REGION.av-b}"

    tags = {
        Name = "fs-subnet-private-2"
    }
}
# Internet GW
resource "aws_internet_gateway" "fs-gw" {
    vpc_id = "${aws_vpc.fs-vpc.id}"

    tags = {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "fs-route-public" {
    vpc_id = "${aws_vpc.fs-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.fs-gw.id}"
    }

    tags = {
        Name = "fs-route-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "fs-route-public-assoc-1" {
    subnet_id = "${aws_subnet.fs-subnet-public-1.id}"
    route_table_id = "${aws_route_table.fs-route-public.id}"
}
resource "aws_route_table_association" "fs-route-public-assoc-2" {
    subnet_id = "${aws_subnet.fs-subnet-public-2.id}"
    route_table_id = "${aws_route_table.fs-route-public.id}"
}
