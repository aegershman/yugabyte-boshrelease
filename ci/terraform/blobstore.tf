provider "aws" {
  version = "~> 2.48"
  region  = "us-east-2"
}

resource "aws_s3_bucket" "yugabyte" {
  bucket = "yugabyte-boshrelease"
  acl    = "private"

  tags = {
    name = "yugabyte-boshrelease"
    pun  = "yugabucket"
  }
}

data "aws_iam_policy_document" "yugabyte" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.yugabyte.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "yugabyte" {
  bucket = "${aws_s3_bucket.yugabyte.id}"
  policy = "${data.aws_iam_policy_document.yugabyte.json}"
}
