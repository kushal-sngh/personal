# Grab the ARN of the current logged in user
data "aws_caller_identity" "current" {}

# create a role which allows the current user to assume it
resource "aws_iam_role" "terraform_11270" {
  name = "terraform_11270"
  path = "/test/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_caller_identity.current.arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "terraform_11270" {
  name = "terraform_11270"
  role = "${aws_iam_role.terraform_11270.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*",
        "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# configure this provider alias to only use the IAM Role created above
provider "aws" {
  alias = "iamrole"

  assume_role {
    role_arn = "${aws_iam_role.terraform_11270.arn}"
  }
}

resource "aws_security_group" "primary" {
  name = "primary"
}

# Create a security group with the above IAM Role assumed
resource "aws_security_group" "secondary" {
  provider = "aws.iamrole"
  name     = "secondary"
}
