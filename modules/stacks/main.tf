terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

########################################
# CloudFormation Stack
########################################

# Optional: keep template path configurable
# variable "template_relative_path" {
#   type        = string
#   description = "Relative path (from module root) to the YAML template file."
#   default     = "yaml/iam_user_group.yml"
# }

resource "aws_cloudformation_stack" "cloudformation_stack" {
  name          = var.stack_name

  # Use this if you added the variable above:
  # template_body = file("${path.module}/${var.template_relative_path}")
  template_body = file("${path.module}/yaml/iam_user_group.yml")

  capabilities  = ["CAPABILITY_NAMED_IAM"]

  parameters = {
    UserName   = var.user_name
    GroupName  = var.group_name
    PolicyName = var.policy_name
    TagKey     = var.tag_key
    TagValue   = var.tag_value
  }

  tags = var.tags
}

############################
# Outputs
############################

output "stack_id" {
  value       = aws_cloudformation_stack.cloudformation_stack.id
  description = "The Stack ID"
}

output "stack_status" {
  value       = aws_cloudformation_stack.cloudformation_stack.stack_status
  description = "Current status of the stack"
}
