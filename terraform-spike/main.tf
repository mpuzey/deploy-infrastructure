provider "aws" {
    region = "eu-west-2"
    profile = "azcard"
}

terraform {
  backend "s3" {
    bucket = "${data.aws_s3_bucket.terraform_remote_state_bucket}"
    key    = "${var.environment}-remote-state"
    region = "eu-west-2"
    profile = "azcard"
  }
}


resource "aws_s3_bucket" "terraform_remote_state_bucket" {
  bucket = "terraform-remote-state"
  acl    = "private"

  versioning {
    enabled = "true"
  }

  /* This rule is for archiving old versions of the tf state. */
  lifecycle_rule {
    prefix  = "/"
    enabled = "true"

    noncurrent_version_transition {
      days          = "30"
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = "60"
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = "90"
    }
}
