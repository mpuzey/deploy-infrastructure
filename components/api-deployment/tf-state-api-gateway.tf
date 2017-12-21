/* Remote state of the API gateway */

data "terraform_remote_state" "api_gateway" {
  backend = "s3"

  config {
    bucket = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
    key    = "${var.project}/${data.aws_caller_identity.current.account_id}/${data.aws_region.current.name}/one-time/api-gateway.tfstate"
    region = "${data.aws_region.current.name}"
  }
}
