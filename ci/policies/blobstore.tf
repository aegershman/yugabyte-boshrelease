resource "aws_s3_bucket" "b" {
  bucket = "yugabyte-boshrelease"
  acl    = "private"

  tags = {
    name        = "yugabyte-boshrelease"
  }
}
