# infrastructure/dev/terragrunt.hcl

locals {
  env            = "dev"
  aws_region     = "us-east-1"

  state_bucket   = "abby-deploy-state-dev-01"
  state_dynamodb = "terraform-locks-dev"

  state_key      = "${local.env}/${path_relative_to_include()}/terraform.tfstate"
}

generate "backend" {
  path      = "zz_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.state_bucket}"
    key            = "${local.state_key}"
    region         = "${local.aws_region}"
    dynamodb_table = "${local.state_dynamodb}"
    encrypt        = true
  }
}
EOF
}

# No provider generator here

inputs = {
  tags = {
    Project     = "CloudSecurity"
    DeployedBy  = "Terragrunt"
    Environment = local.env
  }
  template_relative_path = "yaml/iam_user_group.yml"
}
