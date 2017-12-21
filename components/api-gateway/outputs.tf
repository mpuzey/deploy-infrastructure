output "api_gateway_id" {
  value = "${aws_api_gateway_rest_api.api_gateway.id}"
}

output "api_gateway_root_resource_id" {
  value = "${aws_api_gateway_rest_api.api_gateway.root_resource_id}"
  description = "The resource ID of the REST API's root"
}

output "api_gateway_created_date" {
  value = "${aws_api_gateway_rest_api.api_gateway.created_date}"
  description = "The created date of the REST API"
}
