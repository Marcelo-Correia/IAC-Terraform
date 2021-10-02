variable "app_name" {
  default = "hero"
}
variable "aws_region" {
  default = "us-east-1"
}
variable "aws_vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_subnet_pub_cidr_block" {
  default = "10.0.0.1/24"
}
variable "aws_subnet_priv_cidr_block" {
  default = "10.0.0.2/24"
}
variable "zone_subnet" {
  type = string
  default = "available"
}