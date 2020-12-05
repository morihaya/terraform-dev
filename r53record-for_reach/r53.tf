data "aws_vpc" "default" {
  default = true
}

resource "aws_route53_zone" "private" {
  name = "morihaya.tech"
  vpc {
    vpc_id = data.aws_vpc.default.id
  }
  tags = {
    "Make" = "Terraform"
  }
}

resource "aws_route53_record" "private" {
  zone_id = aws_route53_zone.private.zone_id
  for_each = {
    "l2sw01.morihaya.tech" = "192.168.1.21"
    "l2sw02.morihaya.tech" = "192.168.1.22"
    "l3sw01.morihaya.tech" = "192.168.1.31"
    "l3sw02.morihaya.tech" = "192.168.1.32"
    "web01.morihaya.tech"  = "192.168.2.11"
    "web02.morihaya.tech"  = "192.168.2.12"
    "db01.morihaya.tech"   = "192.168.10.11"
    "db02.morihaya.tech"   = "192.168.10.12"
  }
  name    = each.key
  type    = "A"
  ttl     = "300"
  records = [each.value]
}
