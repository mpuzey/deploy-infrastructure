/* API Gateway methods */

resource "aws_api_gateway_method" "resource_method" {
  rest_api_id = "${var.rest_api_id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "${var.http_method}"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "200_json" {

  depends_on = ["aws_api_gateway_method.resource_method"]
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${var.http_method}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}
