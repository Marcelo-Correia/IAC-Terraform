variable "app_name" {
  default = "hero"
}
variable "aws_region" {
  default = "us-east-1"
}
variable "aws_vpc_cidr_block" {
  default = "198.168.0.0/16"
}
variable "aws_subnet_pub_cidr_block" {
  default = "198.168.1.0/24"
}
variable "aws_subnet_priv_cidr_block" {
  default = "198.168.2.0/24"
}
variable "zone_subnet" {
  type = string
  default = "us-east-1a"
}