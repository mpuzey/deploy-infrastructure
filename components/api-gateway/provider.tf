provider "aws" {
    region = "eu-west-2"
}

terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {
  current = true
}