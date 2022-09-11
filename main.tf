terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# S3 Bucket
resource "aws_s3_bucket" "b" {
 bucket = "aws-s3-luis-rm94405-checkpoint02"  
}

# S3 Bucket - Config ACL
resource "aws_s3_bucket_acl" "b-acl" {
  bucket = aws_s3_bucket.b.id
  acl = "public-read"
}

# S3 Bucket - Config Versioning
#resource "aws_s3_bucket_versioning" "b-versioning" {
 # bucket = aws_s3_bucket.b.id
  #versioning_configuration {
   # status = "enabled"
  #}
#}

# S3 Bucket - Config Static Website
resource "aws_s3_bucket_website_configuration" "b-website" {
  bucket = aws_s3_bucket.b.id
  index_document {
    suffix = "index.html"
  }
    error_document {
      key = "error.html"
 }
}

# S3 Bucket Objects
resource "aws_s3_bucket_object" "b-objects" {
    bucket = aws_s3_bucket.b.id
    for_each = fileset("data/", "*")
    key = each.value
    source = "data/${each.value}"
    acl = "public-read"
  
}
