# modules/api_gateway/outputs.tf

output "api_id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.forcepoint_demo.id
}

output "deployment_id" {
  description = "ID of the API Gateway deployment"
  value       = aws_api_gateway_deployment.forcepoint_demo.id
}

output "stage_name" {
  description = "The name of the API Gateway stage"
  value       = var.stage_name
}
