variable "stack_name" {
  type        = string
  description = "Name of the CloudFormation Stack."
  default     = "iam-user-group-stack"
  validation {
    condition     = length(var.stack_name) > 0 && length(var.stack_name) <= 128 && can(regex("^[A-Za-z0-9._-]+$", var.stack_name))
    error_message = "stack_name must be 1-128 chars and only letters, numbers, dot, underscore, or hyphen."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the Stack."
  default     = {
    Project     = "CloudSecurity"
    DeployedBy  = "Terraform"
    Environment = "dev"
  }
}

########################################
# Template parameters (IAM objects)
########################################
variable "user_name" {
  type        = string
  description = "IAM User name to create in the template."
  default     = "StackUser"
}

variable "group_name" {
  type        = string
  description = "IAM Group name to create in the template."
  default     = "StackGroup"
}

variable "policy_name" {
  type        = string
  description = "IAM Policy name to attach in the template."
  default     = "StackPolicy"
}

variable "tag_key" {
  type        = string
  description = "Tag key applied to created IAM resources."
  default     = "Environment"
}

variable "tag_value" {
  type        = string
  description = "Tag value applied to created IAM resources."
  default     = "Dev"
}

# >>> Newly added <<<
variable "template_relative_path" {
  type        = string
  description = "Relative path to the YAML template file."
  default     = "yaml/iam_user_group.yml"
}
