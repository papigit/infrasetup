resource "aws_instance" "webserver" {
  count                   = 2
  ami                     = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type           = "t2.micro"
  iam_instance_profile    = "ec2admin"
  key_name                = "${aws_key_pair.fskey.key_name}"
  monitoring              = true
  subnet_id               = "${aws_subnet.fs-subnet-public-1.id}"
  user_data               = "${file("../source/scripts/bootstrap.sh")}"
  disable_api_termination = false
  vpc_security_group_ids  = [
    "${aws_security_group.fs-sg.id}"
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  tags = {
    Name                     = "${format("webserver-%02d", count.index + 1)}"
    Type                     = "EC2 Instance"
    Monitoring               = "true"
  }
}
