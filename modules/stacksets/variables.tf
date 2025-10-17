variable "management_region" {
  type        = string
  description = "AWS region of the management/delegated-admin account where StackSets is managed."
  default     = "us-east-1"
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-\\d$", var.management_region))
    error_message = "management_region must look like an AWS region, e.g. us-east-1."
  }
}

variable "stackset_name" {
  type        = string
  description = "Name of the CloudFormation StackSet."
  default     = "terraform-stackset-deployment"
  validation {
    condition     = length(var.stackset_name) > 0 && length(var.stackset_name) <= 128 && can(regex("^[A-Za-z0-9._-]+$", var.stackset_name))
    error_message = "stackset_name must be 1-128 chars and only letters, numbers, dot, underscore, or hyphen."
  }
}

variable "description" {
  type        = string
  description = "Description for the StackSet."
  default     = "Deploy IAM resources across AWS member accounts via StackSets (service-managed)."
}

variable "call_as" {
  type        = string
  description = "Whether to call as SELF (management account) or DELEGATED_ADMIN (registered delegated admin)."
  default     = "DELEGATED_ADMIN"
  validation {
    condition     = contains(["SELF", "DELEGATED_ADMIN"], var.call_as)
    error_message = "call_as must be either SELF or DELEGATED_ADMIN."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the StackSet."
  default     = {
    Project     = "CloudSecurity"
    DeployedBy  = "Terraform"
    Environment = "prod"
  }
}

########################################
# Template parameters (IAM objects)
########################################
variable "user_name" {
  type        = string
  description = "IAM User name to create in the template."
  default     = "StackSetUser"
}

variable "group_name" {
  type        = string
  description = "IAM Group name to create in the template."
  default     = "StackSetGroup"
}

variable "policy_name" {
  type        = string
  description = "IAM Policy name to attach in the template."
  default     = "StackSetPolicy"
}

variable "tag_key" {
  type        = string
  description = "Tag key applied to created IAM resources."
  default     = "Environment"
}

variable "tag_value" {
  type        = string
  description = "Tag value applied to created IAM resources."
  default     = "Prod"
}

# >>> Newly added <<<
variable "template_relative_path" {
  type        = string
  description = "Relative path to the YAML template file."
  default     = "yaml/iam_user_group.yml"
}

########################################
# Auto-deployment / execution behavior
########################################
variable "auto_deployment_enabled" {
  type        = bool
  description = "Enable automatic deployment to new accounts in the target OUs."
  default     = true
}

variable "retain_stacks_on_account_removal" {
  type        = bool
  description = "Retain member stacks when an account is removed from target OUs."
  default     = true
}

variable "managed_execution_active" {
  type        = bool
  description = "Whether to enable StackSet managed execution."
  default     = true
}

########################################
# Operation preferences / timeouts
########################################
variable "max_concurrent_percentage" {
  type        = number
  description = "Maximum percentage of accounts where operations are performed concurrently."
  default     = 20
  validation {
    condition     = var.max_concurrent_percentage >= 0 && var.max_concurrent_percentage <= 100
    error_message = "max_concurrent_percentage must be between 0 and 100."
  }
}

variable "failure_tolerance_percentage" {
  type        = number
  description = "Percentage of accounts that can fail before the operation fails."
  default     = 0
  validation {
    condition     = var.failure_tolerance_percentage >= 0 && var.failure_tolerance_percentage <= 100
    error_message = "failure_tolerance_percentage must be between 0 and 100."
  }
}

variable "update_timeout" {
  type        = string
  description = "Timeout for StackSet update operations (e.g., 30m, 1h)."
  default     = "45m"
  validation {
    condition     = can(regex("^\\d+[smh]$", var.update_timeout))
    error_message = "update_timeout must be in Go duration style like 30m, 90s, or 1h."
  }
}

########################################
# Targeting (regions / OUs)
########################################
variable "regions" {
  type        = list(string)
  description = "List of regions to create StackSet instances in."
  default     = ["us-east-1"]
  validation {
    condition     = length(var.regions) > 0 && alltrue([for r in var.regions : can(regex("^[a-z]{2}-[a-z]+-\\d$", r))])
    error_message = "Each entry in regions must look like an AWS region, e.g. us-east-1."
  }
}

variable "organizational_unit_ids" {
  type        = list(string)
  description = "Target OU IDs for service-managed StackSets. Leave empty to skip OU targeting."
  default     = []
  validation {
    condition     = alltrue([for ou in var.organizational_unit_ids : can(regex("^ou-[a-z0-9-]+", lower(ou)))])
    error_message = "Each OU ID should start with 'ou-' (e.g., ou-1234-abcdef12)."
  }
}
