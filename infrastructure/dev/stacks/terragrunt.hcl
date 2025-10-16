terraform {
  # modules is at repo root (same level as infrastructure),
  # so from dev/stacks we go ../../../modules/stacks
  source = "../../../modules/stacks"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  stack_name  = "iam-user-group-stack"
  user_name   = "StackUser"
  group_name  = "StackGroup"
  policy_name = "StackPolicy"
  tag_key     = "Environment"
  tag_value   = "Dev"
  # tags + template_relative_path inherited from parent
}
