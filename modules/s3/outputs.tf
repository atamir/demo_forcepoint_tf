output "s3_bucket_name" {
  description = "Name of the S3 bucket for Lambda function code storage"
  value       = aws_s3_bucket.lambda_code.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for Lambda function code storage"
  value       = aws_s3_bucket.lambda_code.arn
}
