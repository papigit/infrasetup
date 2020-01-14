variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "ap-southeast-1"
}
variable "AWS_SB_REGION" {
  type = "map"
  default = {
   av-a = "ap-southeast-1a"
   av-b = "ap-southeast-1b"
   av-c = "ap-southeast-1c"
}
}
variable "AMIS" {
   type = "map"
   default = {
    ap-southeast-1 = "ami-0fb6b6f9e81056553"
  }
}