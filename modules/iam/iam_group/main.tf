resource "aws_iam_group" "this" {
  name = var.group_name
  path = var.path
}

# Attach AWS managed policies to the group
resource "aws_iam_group_policy_attachment" "managed" {
  for_each   = toset(var.managed_policy_arns)
  group      = aws_iam_group.this.name
  policy_arn = each.value
}

# Add users to the group
resource "aws_iam_group_membership" "members" {
  name  = "${aws_iam_group.this.name}-membership"
  users = var.user_names
  group = aws_iam_group.this.name
}
