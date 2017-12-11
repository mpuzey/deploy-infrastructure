data "terraform_remote_state" "lambda_artifacts_s3_bucket" {
  backend = "s3"

  config {
    bucket = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
    key = "${var.project}/${data.aws_caller_identity.current.account_id}/${data.aws_region.current.name}/one-time/lambda-artifacts.tfstate"
    region = "${data.aws_region.current.name}"
  }
}
