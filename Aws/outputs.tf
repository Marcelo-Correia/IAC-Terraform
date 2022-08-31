output "instance_ip_addr" {
  value = aws_instance.ubuntu.public_ip
}
