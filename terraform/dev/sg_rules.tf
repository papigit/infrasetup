resource "aws_security_group_rule" "security_rule_instances" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}

resource "aws_security_group_rule" "icmp_security_rule" {
  type              = "ingress"
  from_port         = "-1"
  to_port           = "-1"
  protocol          = "icmp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}

resource "aws_security_group_rule" "http_security_rule" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}

resource "aws_security_group_rule" "https_security_rule" {
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}

resource "aws_security_group_rule" "security_rule_8080" {
  type              = "ingress"
  from_port         = "8080"
  to_port           = "8080"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}
resource "aws_security_group_rule" "security_rule_8000" {
  type              = "ingress"
  from_port         = "8000"
  to_port           = "8000"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}


resource "aws_security_group_rule" "default_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}

resource "aws_security_group_rule" "db_range" {
  type              = "ingress"
  from_port         = "5400"
  to_port           = "5430"
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = "${aws_security_group.fs-sg.id}"
}
