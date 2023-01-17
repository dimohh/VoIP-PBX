# Deploy S3 bucket for storing remote state file

resource "aws_s3_bucket" "terraform_backend_bucket" {
  bucket = "asterisk-terraform-backend"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
      prevent_destroy = true 
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Deploy DynamoDB table as state locking mechanism

resource "aws_dynamodb_table" "terraform_backend_table" {
  name           = "asterisk-tf-state-locking"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}
# Terraform behavior attributes

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
   backend "s3" {
    bucket  = "asterisk-terraform-backend"
    key     = "asterisk.tfstate"
    region  = "eu-west-1"
  }
}

# Default AWS provider

provider "aws" {
  region    = "eu-west-1"
}
