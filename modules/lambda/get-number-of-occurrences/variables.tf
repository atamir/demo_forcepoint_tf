# Variables for get-number-of-occurrences Lambda module
variable "function_name" {
  description = "Name of the get-number-of-occurrences Lambda function"
  type        = string
  default     = "get-number-of-occurrences"
}

variable "role_name" {
  description = "Name of the IAM role for the get-number-of-occurrences Lambda function"
  type        = string
  default     = "lambda_execution_role2"
}

variable "lambda_s3_bucket" {
  description = "S3 bucket name containing the get-number-of-occurrences Lambda function code"
  type        = string
  default     = "lambda-zip-files-forcepoint-demo"
}

variable "lambda_s3_key" {
  description = "S3 object key for the get-number-of-occurrences Lambda function code"
  type        = string
  default     = "my_deployment_package.zip"
}

variable "lambda_zip_file" {
  description = "Path to the ZIP file containing the get-number-of-occurrences Lambda function code"
  type        = string
  default     = "./src/get-number-of-occurrences/my_deployment_package.zip"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to store the Lambda ZIP file"
  type        = string
  default     = "lambda-zip-files-forcepoint-get-function"
}

variable "lambda_zip_file_path" {
  description = "Local path to the Lambda ZIP file to upload"
  type        = string
  default     = "./src/get-number-of-occurrences/my_deployment_package.zip"
}
