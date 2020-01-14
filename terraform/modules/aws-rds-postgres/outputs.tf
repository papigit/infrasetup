output "db_address" {
  value = "${aws_db_instance.mod_rds.address}"
}

output "db_endpoint" {
  value = "${aws_db_instance.mod_rds.endpoint}"
}

output "db_user" {
  value = "${aws_db_instance.mod_rds.username}"
}

