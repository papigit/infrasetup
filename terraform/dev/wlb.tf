resource "aws_lb" "fs-wlb" {
  name               = "fs-wlb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.fs-subnet-public-1.id}", "${aws_subnet.fs-subnet-public-2.id}"]
  security_groups    = ["${aws_security_group.fs-sg.id}"]

  tags = {
    Name = "fs-wlb"
  }
}
resource "aws_lb_target_group" "wlb-to-ip" {
  name        = "wlb-to-ip"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${aws_vpc.fs-vpc.id}"
}
resource "aws_lb_target_group_attachment" "wlb-attach-target" {
  count            = 2
  target_group_arn = "${aws_lb_target_group.wlb-to-ip.arn}"
  target_id        = "${aws_instance.webserver[count.index].id}"
  port             = 80
}
resource "aws_lb_listener" "fs-wlb-listener" {
  load_balancer_arn = "${aws_lb.fs-wlb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.wlb-to-ip.arn}"
  }
}