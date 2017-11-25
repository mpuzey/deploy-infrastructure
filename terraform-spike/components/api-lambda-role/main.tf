provider "aws" {
    region = "eu-west-2"
    profile = "azcard"
}

terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "eu-west-2"
  }
}


resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-remote-state"
  acl    = "private"

  versioning {
    enabled = "true"
  }
}
