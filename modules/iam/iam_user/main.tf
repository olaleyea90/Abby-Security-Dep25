resource "aws_iam_user" "this" {
  name = var.user_name
  path = var.path
  tags = var.tags
}

# Optional access key (off by default)
resource "aws_iam_access_key" "this" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.this.name
}
