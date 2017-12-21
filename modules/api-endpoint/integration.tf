/* API Gateway integration */

resource "aws_api_gateway_integration" "integration" {

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.resource_method.http_method}"
  integration_http_method = "POST"
  type                    = "${var.integration_type}"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arn}:$${stageVariables.lambdaAlias}/invocations"
}
