output "user_name" {
  value       = aws_iam_user.this.name
  description = "IAM user name"
}

output "user_arn" {
  value       = aws_iam_user.this.arn
  description = "IAM user ARN"
}

output "access_key_id" {
  value       = try(aws_iam_access_key.this[0].id, null)
  description = "Access key ID (if created)"
  sensitive   = true
}

output "secret_access_key" {
  value       = try(aws_iam_access_key.this[0].secret, null)
  description = "Secret access key (if created). Store securely!"
  sensitive   = true
}
