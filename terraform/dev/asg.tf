resource "aws_launch_configuration" "fs-launch-config" {
  name_prefix          = "fs-launch-config"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.fskey.key_name}"
  security_groups      = ["${aws_security_group.fs-sg.id}"]
}

resource "aws_autoscaling_group" "fs-asg" {
  name                 = "fs-asg"
  vpc_zone_identifier  = ["${aws_subnet.fs-subnet-public-1.id}"]
  launch_configuration = "${aws_launch_configuration.fs-launch-config.name}"
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
      key = "Name"
      value = "ec2 instance"
      propagate_at_launch = true
  }
}
