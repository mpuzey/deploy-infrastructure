resource "aws_s3_bucket" "lambda_artifacts_s3_bucket" {
  bucket = "lambda-artifacts-${data.aws_caller_identity.current.account_id}"
}
