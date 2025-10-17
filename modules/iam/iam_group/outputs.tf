output "group_name" {
  value       = aws_iam_group.this.name
  description = "IAM group name"
}

output "attached_policies" {
  value       = [for k, v in aws_iam_group_policy_attachment.managed : v.policy_arn]
  description = "List of attached managed policy ARNs"
}
