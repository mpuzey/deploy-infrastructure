output "remote_state_bucket_arn" {
  value = "${aws_s3_bucket.tf_remote_state_bucket.arn}"
}

output "remote_state_bucket_name" {
  value = "${aws_s3_bucket.tf_remote_state_bucket.id}"
}
