provider "aws" {
  alias = "test"
  version = "~> 1.4"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::925313776336:role/jenkins-inst-prof-role"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  provider = "aws.test"
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags {
    Name        = "test_bucket"
    Environment = "Dev"
  }
}
