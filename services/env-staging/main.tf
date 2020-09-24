# configure provider credentials
provider "aws" {
  region                  = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
}

terraform {
# put a pin on the harshicorp aws plugin versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0.0"
    }
  }

#configure s3 backend for state
  required_version = "~> 0.13.0"

  backend "s3" {
    bucket         = "tf-dev-state-bucket"
    key            = "global/s3/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "tf-dev-state-lock"
    encrypt        = true
  }
}


# configure s3 bucket for tf state
resource "aws_s3_bucket" "this" {
  bucket = "tf-dev-state-bucket"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Environment = "Dev"
    Terraform   = "true"
  }
}

# configure aws dynamodb table for state locks
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-dev-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = "Dev"
    Terraform   = "true"
  }
}
