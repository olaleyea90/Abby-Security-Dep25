terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

#########################################
# CloudFormation StackSet & Instances
#########################################

resource "aws_cloudformation_stack_set" "cloudformation_stackset" {
  name             = var.stackset_name
  capabilities     = ["CAPABILITY_NAMED_IAM"]
  description      = var.description
  permission_model = "SERVICE_MANAGED"
  call_as          = var.call_as
  tags             = var.tags

  # Optional: make the path configurable via a variable if you added one
  # template_body = file("${path.module}/${var.template_relative_path}")
  template_body = file("${path.module}/yaml/iam_user_group.yml")

  auto_deployment {
    enabled                          = var.auto_deployment_enabled
    retain_stacks_on_account_removal = var.retain_stacks_on_account_removal
  }

  parameters = {
    UserName   = var.user_name
    GroupName  = var.group_name
    PolicyName = var.policy_name
    TagKey     = var.tag_key
    TagValue   = var.tag_value
  }

  managed_execution {
    active = var.managed_execution_active
  }

  operation_preferences {
    max_concurrent_percentage    = var.max_concurrent_percentage
    failure_tolerance_percentage = var.failure_tolerance_percentage
  }

  timeouts {
    update = var.update_timeout
  }
}

resource "aws_cloudformation_stack_set_instance" "cloudformation_stackset_instance" {
  for_each                  = toset(var.regions)

  stack_set_name            = aws_cloudformation_stack_set.cloudformation_stackset.id
  call_as                   = var.call_as
  stack_set_instance_region = each.value

  deployment_targets {
    organizational_unit_ids = length(var.organizational_unit_ids) > 0 ? var.organizational_unit_ids : null
  }
}

############################
# Outputs
############################

output "stack_set_id" {
  value       = aws_cloudformation_stack_set.cloudformation_stackset.id
  description = "The StackSet ID"
}

output "stack_set_name" {
  value       = aws_cloudformation_stack_set.cloudformation_stackset.name
  description = "The StackSet name"
}
