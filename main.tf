# PROVIDER
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# REGION
provider "aws" {
    region = "us-east-1"
   # shared_credentials_file = ".aws/credentials"
}

# S3
resource "aws_s3_bucket" "fiap-cloud-vds-aws-s3-alef" {
  bucket = "aws-s3-luis-rm94405-checkpoint02"
}

# S3 PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.aws-s3-luis-rm94405-checkpoint02.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# S3 UPLOAD OBJECT
resource "aws_s3_bucket_object" "error" {
  key = "error.html"
  bucket = aws_s3_bucket.aws-s3-luis-rm94405-checkpoint02.id
  source = "error.html"
  acl = "public-read"
}

resource "aws_s3_bucket_object" "index" {
  key = "index.html"
  bucket = aws_s3_bucket.aws-s3-luis-rm94405-checkpoint02.id
  source = "index.html"
  acl = "public-read"
}

# S3 WEBSITE CONFIGURATION
resource "aws_s3_bucket_website_configuration" "fiapwebsite" {
  bucket = aws_s3_bucket.aws-s3-luis-rm94405-checkpoint02.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
