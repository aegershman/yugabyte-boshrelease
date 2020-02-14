provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

resource "aws_s3_bucket" "yugabyte" {
  bucket     = "yugabyte-boshrelease"
  acl        = "private"
  policy     = "${file("bucket-policy.json")}"
  region     = "us-east-2"
  versioning = { enabled = true }

  tags = {
    name = "yugabyte-boshrelease"
    pun  = "yugabucket"
  }
}
