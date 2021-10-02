provider "aws" {
  region = var.aws_region
}

# Get ami
data "aws_ssm_parameter" "webserver" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}


