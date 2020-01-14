data  "template_file" "inventory" {
    template = "${file("ansible.tpl")}"
    vars = {
        webserverip = "${join("\n", aws_instance.webserver.*.public_ip)}"
        appserverip = "${join("\n", aws_instance.appserver.*.public_ip)}"
        dbendpoint = "${module.custopostdb.db_endpoint}"
        albdns = "${aws_lb.fs-alb.dns_name}"
        wlbdns = "${aws_lb.fs-wlb.dns_name}"
    }
}
resource "local_file" "ansible_inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "../../playbooks/hosts"
}
module "custopostdb" {
  source = "../modules/aws-rds-postgres"

  alarm_cpu_threshold         = "75"
  alarm_disk_queue_threshold  = "10"
  alarm_free_disk_threshold   = "5000000"
  alarm_free_memory_threshold = "1280000"
  engine_version              = "11.4-R1"  
  instance_type               = "db.t2.small"
  db_name                     = "custodb"
  db_port                     = "5432"
  multiaz                     = false
  storage_size                = "20"
  skip_final_snapshot         = true
  final_snapshot_identifier   = "finalsnaptaug31"
  vpc_id                      = "${aws_vpc.fs-vpc.id}"
}
