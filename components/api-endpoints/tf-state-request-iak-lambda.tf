/* Remote state of the request-iak lambda */

data "terraform_remote_state" "request_iak_lambda" {
  backend = "s3"

  config {
    bucket = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
    key    = "${var.project}/${data.aws_caller_identity.current.account_id}/${data.aws_region.current.name}/lambda/request_iak.tfstate"
    region = "${data.aws_region.current.name}"
  }
}
