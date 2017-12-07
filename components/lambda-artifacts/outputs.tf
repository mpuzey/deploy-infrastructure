output "lambda_artifacts_s3_bucket_id" {
  value = "${aws_s3_bucket.lambda_artifacts_s3_bucket.id}"
}

output "lambda_artifacts_s3_bucket_arn" {
  value = "${aws_s3_bucket.lambda_artifacts_s3_bucket.arn}"
}

output "lambda_artifacts_s3_bucket_domain_name" {
  value = "${aws_s3_bucket.lambda_artifacts_s3_bucket.bucket_domain_name}"
}