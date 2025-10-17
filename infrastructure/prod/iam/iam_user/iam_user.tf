# IAM user
variable "allow_destroy" {
  type    = bool
  default = false
}

resource "aws_iam_user" "abby_sep_user" {
  name          = "abby_sep_user"
  force_destroy = true
  lifecycle {
    prevent_destroy = var.allow_destroy ? false : true
  }
  tags = {
    Owner     = "Infra"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_user_login_profile" "abby_console" {
  user                    = aws_iam_user.abby_sep_user.name
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "user_admin" {
  user       = aws_iam_user.abby_sep_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_policy_attachment" "user_s3_readonly" {
  user       = aws_iam_user.abby_sep_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
