resource "aws_iam_role" "iam_lambda" {
  name = "lambda-role"

  managed_policy_arns = [
    aws_iam_policy.lambda_s3_policy.arn,
  ]

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_encrypted" {
  function_name    = var.function_name
  role             = aws_iam_role.iam_lambda.arn
  handler          = "main.handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = var.python_version

  environment {
    variables = {
      S3_ENCRYPTED_BUCKET = aws_s3_bucket.s3_encrypted.id
    }
  }
}
