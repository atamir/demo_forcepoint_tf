module "lambda_s3_bucket" {
  source      = "../../s3"
  bucket_name = "lambda-zip-files-forcepoint-calculate-function"
}
resource "aws_s3_bucket_object" "lambda_zip" {
  bucket = var.s3_bucket_name
  key    = var.lambda_s3_key

  source = var.lambda_zip_file_path

  content_type = "application/zip"  # Specify the appropriate content type for a ZIP file
}
resource "aws_lambda_function" "calculate_function" {
  function_name = var.function_name
  handler      = "index.calculate"
  runtime      = "python3.8"
  s3_bucket    = var.lambda_s3_bucket
  s3_key       = var.lambda_s3_key

  # Define the IAM role for the Lambda function
  role = aws_iam_role.lambda_execution_role.arn

  # Add other configuration as needed
  # ...

  # Define the Lambda function source code (e.g., S3 bucket object)
  source_code_hash = filebase64sha256(var.lambda_zip_file)
}

resource "aws_iam_role" "lambda_execution_role" {
  name = var.role_name

  # Attach necessary policies and permissions to the role
  # ...

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
