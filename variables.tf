variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "function_name" {
  description = "The Lambda Function name"
  type        = string
  default     = "kantox-lambda"
}

variable "python_version" {
  description = "Python version for the lambda fn"
  type        = string
  default     = "python3.8"
}

variable "lambda_policy_name" {
  description = "Lambda policy name"
  type        = string
  default     = "lambda-s3-policy"
}

variable "bucket_file_name" {
  description = "bucket file name"
  type        = string
  default     = "jedi.json"
}

variable "bucket_name" {
  description = "bucket name"
  type        = string
  default     = "kantox-poc-bucket"
}
