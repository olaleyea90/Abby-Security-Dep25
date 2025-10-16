module "stacksets" {
  source      = "../../..//modules/stacksets"
  management_region        = "us-east-1"
  stackset_name            = "Moncton-Stackset"
  call_as                  = "SELF"
  stack_name               = "Moncton-stackname"
  user_name                = "Moncton-Username"
  group_name               = "Moncton-groupName"
  policy_name              = "Moncton-PolicyName"
  tag_value                = "Moncton"
  tag_key                  = "Security"
  tags                     = { Teams = "SecurityTeam" }

  account_ids = [                        
    "225828829720",  # first account
    "089443085194"   # second account
  ]

  organizational_unit_ids = ["r-v7o4"]
}
