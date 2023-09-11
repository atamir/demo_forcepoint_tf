# modules/api_gateway/variables.tf

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "forcepoint_demo"
}

variable "stage_name" {
  description = "Name of the API Gateway stage"
  type        = string
}

#variable "lambda_uri" {
#  description = "URI of the Lambda function integration"
#  type        = string
#}



variable "lambda_function_calculate_arn" {
  description = "ARN of the calculate Lambda function"
  type        = string
}

variable "lambda_function_get_arn" {
  description = "ARN of the get Lambda function"
  type        = string
}
