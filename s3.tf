resource "aws_s3_bucket" "s3_encrypted" {
  bucket               = var.bucket_name
  acl                  = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = module.kms.key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Description: This file uploads json file to the encrypted S3 bucket
resource "aws_s3_object" "file_encrypted" {
  key    = var.bucket_file_name
  bucket = aws_s3_bucket.s3_encrypted.id
  source = "${path.module}/lambda/jedi.json"
}
