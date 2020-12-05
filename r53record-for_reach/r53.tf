data "aws_vpc" "default" {
  default = true
}

resource "aws_route53_zone" "private" {
  name = "morihaya.tech"
  vpc {
    vpc_id = data.aws_vpc.default.id
  }
  tags          = {
    "Make" = "Terraform"
  }
}
