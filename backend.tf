terraform {
  backend "s3" {
    bucket         	   = "kantox-terraform-backend-poc"
    key              	   = "state/terraform.tfstate"
    region         	   = "eu-central-1"
    encrypt        	   = true
    dynamodb_table         = "terraform-state-lock-dynamo"
    access_key             = "AKIAVJAHCUXAFV4EAQFQ"
    secret_key             = "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"
  }
}
