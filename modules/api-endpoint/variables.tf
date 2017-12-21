/* Variables for the modules api endpoint */

variable "rest_api_id" {
  type = "string"
  description = "The ID of the API Gateway REST API"
}

variable "root_resource_id" {
  type = "string"
  description = "The resource ID of the REST API's root"
}

variable "lambda_arn" {
  type = "string"
  description = "The arn for the lambda to be invoked by the api endpoint"
}

variable "path_part" {
  type = "string"
  description = "The last path segment of the API resource."
}

variable "http_method" {
  type = "string"
  description = "The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTION, ANY)"
}

variable "region" {
  type = "string"
  description = "The AWS region"
}

variable "integration_type" {
  type = "string"
  description = "The type of integration in API gateway i.e. AWS or AWS Proxy in the case of a lambda proxy integration"
}

variable "response_model_type" {
  type = "string"
  description = "The method response model i.e. text/html or application/json"
}
