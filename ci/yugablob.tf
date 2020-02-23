terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "aegershman"

    workspaces {
      name = "yugabyte-boshrelease"
    }
  }
}

provider "aws" {
  version = "~> 2.50"
  region  = "us-east-2"
}

####################################
# blobstore bucket
####################################

resource "aws_s3_bucket" "yugabyte" {
  bucket = "yugabyte-boshrelease"
  acl    = "private"

  tags = {
    name = "yugabyte-boshrelease"
    pun  = "yugabucket"
  }
}

data "aws_iam_policy_document" "yugabyte_bucket_public_read" {
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
  policy = "${data.aws_iam_policy_document.yugabyte_bucket_public_read.json}"
}

####################################
# service account for writing to the blobstore
####################################

resource "aws_iam_user" "yugabyte" {
  name = "yugabyte"

  tags = {
    name = "yugabyte-boshrelease"
    pun  = "yugabot"
  }
}

data "aws_iam_policy_document" "yugabyte_blobstore_write" {
  statement {
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.yugabyte.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "yugabyte_blobstore_write" {
  name        = "yugabyte-blobstore-write"
  description = "yugabyte-boshrelease blobstore bucket write permission"
  policy      = "${data.aws_iam_policy_document.yugabyte_blobstore_write.json}"
}

resource "aws_iam_user_policy_attachment" "yugabyte" {
  user       = "${aws_iam_user.yugabyte.name}"
  policy_arn = "${aws_iam_policy.yugabyte_blobstore_write.arn}"
}

####################################
# access key for that service account
####################################

resource "aws_iam_access_key" "yugabyte" {
  user = "${aws_iam_user.yugabyte.name}"
  pgp_key = keybase:aegershman
}

output "yugabyte_access_key_id" {
  value = "${aws_iam_access_key.yugabyte.id}"
}

output "yugabyte_secret_access_key" {
  value = "${aws_iam_access_key.yugabyte.encrypted_secret}"
}
