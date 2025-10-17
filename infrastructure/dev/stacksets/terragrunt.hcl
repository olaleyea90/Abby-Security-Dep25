terraform {
  source = "../../../modules/stacksets"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  management_region                = "us-east-1"
  stackset_name                    = "terraform-stackset-deployment"
  description                      = "Deploy IAM resources across AWS member accounts via StackSets (service-managed)."

  call_as                          = "DELEGATED_ADMIN"
  auto_deployment_enabled          = true
  retain_stacks_on_account_removal = true
  managed_execution_active         = true

  max_concurrent_percentage        = 20
  failure_tolerance_percentage     = 0
  update_timeout                   = "45m"

  regions                          = ["us-east-1"]
  organizational_unit_ids          = []  # or ["ou-xxxx-yyyyyyyy"]

  user_name                        = "StackSetUser"
  group_name                       = "StackSetGroup"
  policy_name                      = "StackSetPolicy"
  tag_key                          = "Environment"
  tag_value                        = "Dev"
  # tags + template_relative_path inherited from parent
}
