module "stack"
 source =  "../../..//modules/stacks"
 
 resource "aws_cloudformation_stack" "cloudformation_stack" {
  name          = "MyTerraformFirstStack"
  template_body = file("${path.module}/yaml/iam_user_group.yml")
  capabilities  = ["CAPABILITY_NAMED_IAM"] #this is only added when you are creating an IAM RESOURCES.
  parameters = {
    UserName   = "MyTerraform_FirstStack-UserName"
    GroupName  = "MyTerraform_FirstStack-group"
    PolicyName = "MyTerraform_FirstStack-PolicyName"
    TagKey     = "MyTerraform_FirstStack-TagKey"
    TagValue   = "MyTerraform_FirstStack-TagKey"
  }
  tags = {
    Name = "cloudformation-template-deployment"
  }
}
