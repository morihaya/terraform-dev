terraform {
  backend "s3" {
    bucket = "terraform.morihaya.tech"
    key    = "github.co.jp/morihaya/terraform-dev/r53record-for_reach/terraform.tfstate"
    region = "us-east-2"
  }
}

