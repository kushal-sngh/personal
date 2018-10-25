provider "aws" {
  version = "~> 1.4"
  region  = "us-east-1"
  profile = "default"
  assume_role {
    role_arn = "arn:aws:iam::337089113773:role/jenkins-slave-prof-role"
  }
}
resource "aws_security_group" "primary" {
  name = "primary-test-sg"
}
