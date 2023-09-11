resource "aws_s3_bucket" "lambda_code" {
  bucket = var.bucket_name


   versioning {
     enabled = true
   }
}
