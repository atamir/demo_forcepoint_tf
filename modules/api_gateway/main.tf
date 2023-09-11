# modules/api_gateway/main.tf

resource "aws_api_gateway_rest_api" "forcepoint_demo" {
  name        = var.api_name
  description = "demo API Gateway"
}

resource "aws_api_gateway_resource" "resource_calculate" {
  rest_api_id = aws_api_gateway_rest_api.forcepoint_demo.id
  parent_id   = aws_api_gateway_rest_api.forcepoint_demo.root_resource_id
  path_part   = "calculate"  # Ensure this path is correct
}

resource "aws_api_gateway_method" "resource_calculate" {
  rest_api_id   = aws_api_gateway_rest_api.forcepoint_demo.id
  resource_id   = aws_api_gateway_resource.resource_calculate.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration_calculate" {
  rest_api_id             = aws_api_gateway_rest_api.forcepoint_demo.id
  resource_id             = aws_api_gateway_resource.resource_calculate.id
  http_method             = aws_api_gateway_method.resource_calculate.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:il-central-1:lambda:path/2015-03-31/functions/${var.lambda_function_calculate_arn}/invocations"
}

resource "aws_api_gateway_resource" "resource_get" {
  depends_on  = [aws_api_gateway_rest_api.forcepoint_demo]
  rest_api_id = aws_api_gateway_rest_api.forcepoint_demo.id
  parent_id   = aws_api_gateway_rest_api.forcepoint_demo.root_resource_id
  path_part   = "get"  # Ensure this path is correct
}

resource "aws_api_gateway_method" "resource_get" {
  rest_api_id   = aws_api_gateway_rest_api.forcepoint_demo.id
  resource_id   = aws_api_gateway_resource.resource_get.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "lambda_integration_get" {
  rest_api_id             = aws_api_gateway_rest_api.forcepoint_demo.id
  resource_id             = aws_api_gateway_resource.resource_get.id
  http_method             = aws_api_gateway_method.resource_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:il-central-1:lambda:path/2015-03-31/functions/${var.lambda_function_get_arn}/invocations"

}

resource "aws_api_gateway_deployment" "forcepoint_demo" {
  depends_on      = [aws_api_gateway_integration.lambda_integration_calculate,
                     aws_api_gateway_integration.lambda_integration_get,
                   ]
  rest_api_id     = aws_api_gateway_rest_api.forcepoint_demo.id
  stage_name      = var.stage_name
  description     = "forcepoint_demo deployment"
}
