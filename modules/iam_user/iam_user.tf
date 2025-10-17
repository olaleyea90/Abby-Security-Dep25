resource "aws_iam_user" "abby_sep_user" {
  name = "abby.automation"
  path = var.path

  # If you want to protect this from accidental destroy, keep this.
  # Otherwise, remove the lifecycle block entirely.
  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}
