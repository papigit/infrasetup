# nat gw
resource "aws_eip" "fs-nat" {
  vpc      = true
}
resource "aws_nat_gateway" "fs-nat-gw" {
  allocation_id = "${aws_eip.fs-nat.id}"
  subnet_id = "${aws_subnet.fs-subnet-public-1.id}"
  depends_on = ["aws_internet_gateway.fs-gw"]
}

# VPC setup for NAT
resource "aws_route_table" "fs-route-private" {
    vpc_id = "${aws_vpc.fs-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.fs-nat-gw.id}"
    }

    tags = {
        Name = "fs-route-private"
    }
}
# route associations private
resource "aws_route_table_association" "fs-route-private-assoc" {
    subnet_id = "${aws_subnet.fs-subnet-private-1.id}"
    route_table_id = "${aws_route_table.fs-route-private.id}"
}
