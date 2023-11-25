variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "function_name" {
  description = "The Lambda Function name"
  type        = string
  default     = "kantox-lambda-poc"
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
  default     = "kantox-poc-bucket-v2"
}

variable "lambda_role_name" {
  description = "lambda role name"
  type        = string
  default     = "lambda-role"
}
variable "current_user_arn" {
  description = "current user name"
  type        = string
  default     = "arn:aws:iam::362939590080:user/gehal6"
}
