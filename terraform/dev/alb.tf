resource "aws_lb" "fs-alb" {
  name               = "fs-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.fs-subnet-public-1.id}", "${aws_subnet.fs-subnet-public-2.id}"]
  security_groups    = ["${aws_security_group.fs-sg.id}"]

  tags = {
    Name = "fs-alb"
  }
}
resource "aws_lb_target_group" "alb-to-ip" {
  name        = "alb-to-ip"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${aws_vpc.fs-vpc.id}"
}
resource "aws_lb_target_group_attachment" "alb-attach-target" {
  count            = 2
  target_group_arn = "${aws_lb_target_group.alb-to-ip.arn}"
  target_id        = "${aws_instance.appserver[count.index].id}"
  port             = 8080
}
resource "aws_lb_listener" "fs-alb-listener" {
  load_balancer_arn = "${aws_lb.fs-alb.arn}"
  port              = 8000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb-to-ip.arn}"
  }
}