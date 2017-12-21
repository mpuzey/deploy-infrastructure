/* API Gateway */

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "${var.project}-api-gateway"
  description = "${var.project} api gateway"
}
