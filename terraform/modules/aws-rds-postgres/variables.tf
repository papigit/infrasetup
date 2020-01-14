variable "db_name" {}
variable "storage_size" {}
variable "db_port" {}
variable "db_password" { default = "" }
variable "engine_version" {}
variable "engine_family" { default = "postgres9.6" }
variable "instance_type" {}
variable "multiaz" {
  default = true
}
variable "vpc_id" {}
variable "backup_window" { default = "03:01-06:00"}
variable "backup_retention_period" { default = "35" }
# backup_retention_period_compliant is the minimum number of days defined in the SCB group policy # Do not change this below!
variable "backup_retention_period_compliant" { default = "35" }
variable "maintenance_window" { default = "Mon:00:00-Mon:03:00"}
variable "auto_minor_version_upgrade" { default = "true" }
variable "skip_final_snapshot" { default = "false" }
variable "final_snapshot_identifier" { default = "final-snapshot-identifier" }
variable "snapshot_identifier" { default = "snapshot-identifier" }


variable "env" {
  type = "map"
  default = {
    development = "nonprod"
    testing = "nonprod"
    staging = "prod"
    production = "prod"
  }
}



# cloud watch metrics

variable "alarm_cpu_threshold" {
  default = "80"
}

variable "alarm_disk_queue_threshold" {
  default = "10"
}

variable "alarm_free_disk_threshold" {
  # 5GB
  default = "5000000000"
}

variable "alarm_free_memory_threshold" {
  # 128MB
  default = "128000000"
}

variable "alarm_rds_burst_bucket_threshold" {
  default = "30"
}

variable "alarm_rds_swap_usage_threshold" {
  default = "3750000000" # 3.75GB
}


// Tags

variable "requestor" {
  default = ""
}


variable "location" {
  default = ""
}

variable "cloud_touch" {
  default = ""
}

variable "propriety_db" {
  default = ""
}

variable "propriety_web" {
  default = ""
}

variable "propriety_mq" {
  default = ""
}

variable "propriety_infra" {
  default = ""
}

variable "propriety_other" {
  default = ""
}

variable "user_defined_tag1" {
  default = ""
}

variable "user_defined_tag2" {
  default = ""
}

variable "user_defined_tag3" {
  default = ""
}
variable "rds_kms_key" {
  default = ""
}

variable "jira_id" {
  default = ""
}
