resource "aws_iam_group" "this" {
  name = var.group_name
  path = var.path
  tags = var.tags
}

resource "aws_iam_group_policy_attachment" "managed" {
  for_each  = toset(var.managed_policy_arns)
  group     = aws_iam_group.this.name
  policy_arn = each.value
}

resource "aws_iam_group_membership" "members" {
  name  = "${aws_iam_group.this.name}-membership"
  group = aws_iam_group.this.name
  users = var.user_names
}

output "group_name" { value = aws_iam_group.this.name }
output "attached_policies" {
  value = [for k, v in aws_iam_group_policy_attachment.managed : v.policy_arn]
}
