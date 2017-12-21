/* API deployment */

resource "aws_api_gateway_deployment" "deployment" {

  rest_api_id = "${data.terraform_remote_state.api_gateway.api_gateway_id}"
  stage_name  = "${var.environment}"
  description = "API Gateway deployment of the ${var.environment} stage. Deployment time: ${timestamp()}"
  stage_description = "API Gateway deployment of the ${var.environment} stage. Deployment time: ${timestamp()}"

  variables = {
    "lambdaAlias" = "${var.environment}"
  }

}

resource "aws_api_gateway_method_settings" "default" {

  rest_api_id = "${data.terraform_remote_state.api_gateway.api_gateway_id}"
  stage_name  = "${aws_api_gateway_deployment.deployment.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_cloudwatch_log_group" "stage_log_group" {
  name = "API-Gateway-Execution-Logs_${data.terraform_remote_state.api_gateway.api_gateway_id}/${aws_api_gateway_deployment.deployment.stage_name}"
  retention_in_days = "4"

  tags {
    Environment = "${var.environment}"
    Stage       = "${aws_api_gateway_deployment.deployment.stage_name}"
  }
}
