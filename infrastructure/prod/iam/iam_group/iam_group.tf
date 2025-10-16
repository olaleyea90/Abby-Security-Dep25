resource "aws_iam_group" "dynamic_deployment_group" {
  name = "dynamic_deployment_group"
  tags = {
    Owner     = "Infra"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_group_policy_attachment" "group_admin" {
  group      = aws_iam_group.dynamic_deployment_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "group_s3_readonly" {
  group      = aws_iam_group.dynamic_deployment_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_group_membership" "dynamic_deployment_members" {
  name  = "dynamic-deployment-membership"
  group = aws_iam_group.dynamic_deployment_group.name
  users = [aws_iam_user.abby_sep_user.name]
}
