provider "aws" {
    region = "eu-west-2"
    profile = "azcard"
}

terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}
