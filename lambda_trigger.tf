

resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = aws_s3_bucket.s3_event_trigger.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_encrypted.arn
    events              = ["s3:ObjectCreated:*"]

  }
  depends_on = [aws_lambda_permission.grant_s3]
}

resource "aws_lambda_permission" "grant_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name 
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.s3_event_trigger.id}"
}
