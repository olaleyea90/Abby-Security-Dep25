resource "aws_iam_user" "this" {
  name = var.user_name
  path = var.path
  tags = var.tags

  # lifecycle cannot use variables; set a literal
  lifecycle { prevent_destroy = false }
}

resource "aws_iam_access_key" "this" {
  count = var.create_access_key ? 1 : 0
  user  = aws_iam_user.this.name
}

output "user_name" { value = aws_iam_user.this.name }
output "user_arn"  { value = aws_iam_user.this.arn  }
