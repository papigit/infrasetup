resource "aws_security_group" "fs-sg" {
  name        = "fs-sg"
  description = "Ingress from efresh to instances"
  vpc_id      = "${aws_vpc.fs-vpc.id}"

  tags = {
    Name                     = "fs-sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }

  lifecycle {ignore_changes = ["name"]}
}
