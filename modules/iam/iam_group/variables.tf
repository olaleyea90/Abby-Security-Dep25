variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "group_name" {
  type        = string
  description = "IAM group name to create"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path for the IAM group"
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  description = "AWS managed policy ARNs to attach to the group"
}

variable "user_names" {
  type        = list(string)
  default     = []
  description = "User names to add to the group"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the IAM group (note: IAM Group doesn’t support tags in AWS provider, so kept for symmetry)"
}
