locals {
  environment = "prod"          # <-- add this
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "abileye-newbucket-prod"
    key            = "${local.environment}/stacks.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
