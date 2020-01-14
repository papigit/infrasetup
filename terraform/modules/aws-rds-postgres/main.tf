
resource "aws_db_instance" "mod_rds" {
  instance_class             = "${var.instance_type}"
  storage_type               = "gp2"
  storage_encrypted          = "true"
  allocated_storage          = "${var.storage_size}"
  engine                     = "postgres"
  name                       = "${lower(var.db_name)}"
  username                   = "db_admin"
  password                   = "dbpassword123"
  port                       = "${var.db_port}"
  publicly_accessible        = false
  multi_az                   = "${var.multiaz}"

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

