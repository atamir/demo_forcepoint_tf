provider "aws" {
  region = "il-central-1"
}

module "lambda_calculate" {
  source = "./modules/lambda/calculate-number-of-occurrences"
  function_name   = "calculate-number-of-occurrences"
  role_name       = "lambda_execution_role_calculate"
  lambda_s3_bucket = "lambda-zip-files-forcepoint-calculate-function"
  lambda_s3_key    = "my_deployment_package.zip"
  lambda_zip_file  = "./src/calculate-number-of-occurrences/my_deployment_package.zip"
}

module "lambda_get" {
  source = "./modules/lambda/get-number-of-occurrences"
  function_name   = "get-number-of-occurrences"
  role_name       = "lambda_execution_role_get"
  lambda_s3_bucket = "lambda-zip-files-forcepoint-get-function"
  lambda_s3_key    = "my_deployment_package.zip"
  lambda_zip_file  = "./src/get-number-of-occurrences/my_deployment_package.zip"
}

# Define API Gateway
module "api_gateway" {
  source      = "./modules/api_gateway"
  api_name    = "demo-api"
  stage_name  = "dev"
  lambda_function_calculate_arn = module.lambda_calculate.lambda_function_arn
  lambda_function_get_arn = module.lambda_get.lambda_function_arn
}

# Configure API Gateway endpoints and link to Lambda functions
resource "aws_api_gateway_resource" "resource_calculate" {
  parent_id   = module.api_gateway.api_id
  path_part   = "calculate-number-of-occurrences"
  rest_api_id = module.api_gateway.api_id
}
resource "aws_api_gateway_method" "method_calculate" {
  rest_api_id   = module.api_gateway.api_id
  resource_id   = aws_api_gateway_resource.resource_calculate.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_calculate" {
  rest_api_id             = module.api_gateway.api_id
  resource_id             = aws_api_gateway_resource.resource_calculate.id
  http_method             = aws_api_gateway_method.method_calculate.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_calculate.lambda_function_arn
}

# Configure API Gateway endpoints and link to Lambda functions
resource "aws_api_gateway_resource" "resource_get" {
  
  path_part   = "get-number-of-occurrences"
  parent_id   = "aws_api_gateway_rest_api.forcepoint_demo.root_resource_id"
  rest_api_id = "aws_api_gateway_rest_api.forcepoint_demo.id"
}
resource "aws_api_gateway_method" "method_get" {
  rest_api_id   = module.api_gateway.api_id
  resource_id   = aws_api_gateway_resource.resource_get.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_get" {
  rest_api_id             = module.api_gateway.api_id
  resource_id             = aws_api_gateway_resource.resource_get.id
  http_method             = aws_api_gateway_method.method_calculate.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_get.lambda_function_arn
}

# Deploy API Gateway
resource "aws_api_gateway_deployment" "deployment" {
  depends_on      = [aws_api_gateway_integration.integration_calculate, aws_api_gateway_integration.integration_get]
  rest_api_id     = module.api_gateway.api_id
  stage_name      = module.api_gateway.stage_name
  description     = "demo deployment"
}
module "s3" {
  source = "./modules/s3"
}
