provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_user" "ghactions-ami" {
  name = "ghactions-ami"
  force_destroy=true
} 

resource "aws_iam_user" "ghactions-webapp"{
  name = "ghactions-webapp"
  force_destroy = true
}

resource "aws_iam_policy" "ghactions-ami-policy" {
  name = "ghactions-ami-policy"
  policy = file("ghactions-ami-policy.json")
}

resource "aws_iam_policy" "ghactions-webapp-policy"{
  name = "ghactions-webapp-policy"
  policy = file("ghactions-webapp.json")
}
resource "aws_iam_policy_attachment" "policy-attachment" {
  name       = "ghuser-ami-attachment"
  users      = [aws_iam_user.ghactions-ami.name]

  policy_arn = aws_iam_policy.ghactions-ami-policy.arn
  
}

resource "aws_iam_policy_attachment" "ghactions-webapp-policy-attachment" {
  name       = "ghactions-webapp-policy-attachment"
  users      = [aws_iam_user.ghactions-webapp.name]

  policy_arn = aws_iam_policy.ghactions-webapp-policy.arn
  
}


