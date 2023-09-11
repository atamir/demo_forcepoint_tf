# modules/lambda/calculate-number-of-occurrences/outputs.tf

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.calculate_function.arn
}
