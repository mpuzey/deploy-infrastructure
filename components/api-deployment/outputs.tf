output "api_gateway_deployment_id" {
  value = "${aws_api_gateway_deployment.deployment.id}"
}

output "api_gateway_deployment_invoke_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
  description = "The URL to invoke the API pointing to the stage."
}

output "api_gateway_deployment_execution_arn" {
  value = "${aws_api_gateway_deployment.deployment.execution_arn}"
  description = "The execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function."
}

output "api_gateway_deployment_created_date" {
  value = "${aws_api_gateway_deployment.deployment.created_date}"
  description = "The creation date of the deployment."
}
