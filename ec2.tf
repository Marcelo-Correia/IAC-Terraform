#aws instance 
resource "aws_instance" "ubuntu" {
  ami           = data.aws_ssm_parameter.webserver.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_publica.id
  user_data     = file("${path.module}/scripts/user_data.sh")
  tags = {
    name = "${var.app_name}-ec2"
  }
}
