variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "user_name" {
  type        = string
  description = "IAM user name to create"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path for the IAM user"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the IAM user"
}

# Optional: create an access key for the user
variable "create_access_key" {
  type        = bool
  default     = false
  description = "Whether to create an access key for the user"
}
