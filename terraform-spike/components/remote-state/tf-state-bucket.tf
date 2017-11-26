resource "aws_s3_bucket" "tf_remote_state_bucket" {
  bucket = "tf-state-${var.account_id}-${var.region}"
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
}
