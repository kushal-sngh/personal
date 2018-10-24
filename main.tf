provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::337089113773:role/jenkins-slave-prof-role"
    session_name = "ssdev"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags {
    Name        = "test_bucket"
    Environment = "Dev"
  }
}
