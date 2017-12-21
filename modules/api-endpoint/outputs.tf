/* Outputs for the api-endpoint modules */

output "resource_id" {
  value = "${aws_api_gateway_resource.resource.id}"
}

output "resource_path" {
  value = "${aws_api_gateway_resource.resource.path}"
}

output "http_method" {
  value = "${var.http_method}"
}
