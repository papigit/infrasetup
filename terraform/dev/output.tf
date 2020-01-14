output "webserver-ip" {
  value = aws_instance.webserver.*.public_ip
}
output "appserver-ip" {
  value = aws_instance.appserver.*.public_ip
}
output "alb" {
  value = aws_lb.fs-alb.dns_name
}
output "wlb" {
  value = aws_lb.fs-wlb.dns_name
}
output "rds" {
  value = module.custopostdb.db_endpoint
}
