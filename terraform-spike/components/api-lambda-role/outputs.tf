output "api_lambda_role_arn" {
  value = "${aws_iam_role.api_lambda_role.arn}"
}

output "remote_state_bucket_name" {
  value = "${aws_s3_bucket.bucket.name}"
}
