provider "aws" {
  version = "~> 1.4"
  region  = "us-east-1"
  #profile = "default"
  assume_role {
    role_arn = "arn:aws:iam::*******:role/dns-deployment-role"
  }
}
resource "aws_security_group" "primary" {
  name = "primary-test-sg"
}
