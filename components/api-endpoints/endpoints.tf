/* API Gateway endpoints */

module "request_iak_api_endpoint" {
  source = "../../modules/api-endpoint"

  rest_api_id = "${data.terraform_remote_state.api_gateway.api_gateway_id}"
  root_resource_id = "${data.terraform_remote_state.api_gateway.api_gateway_root_resource_id}"
  lambda_arn = "${data.terraform_remote_state.request_iak_lambda.request_iak_arn}"
  path_part = "requestiak"
  http_method = "POST"
  region = "${data.aws_region.current.name}"
  integration_type = "AWS_PROXY"
  response_model_type = "application/json"
}

module "create_iak_api_endpoint" {
  source = "../../modules/api-endpoint"

  rest_api_id = "${data.terraform_remote_state.api_gateway.api_gateway_id}"
  root_resource_id = "${data.terraform_remote_state.api_gateway.api_gateway_root_resource_id}"
  lambda_arn = "${data.terraform_remote_state.create_iak_lambda.create_iak_arn}"
  path_part = "createiak"
  http_method = "GET"
  region = "${data.aws_region.current.name}"
  integration_type = "AWS_PROXY"
  response_model_type = "application/json"
}
