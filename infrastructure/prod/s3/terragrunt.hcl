locals {
  environment = "prod"
}

terraform {
  source = "../../../modules/s3"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "abileye-newbucket-prod"
    key            = "${local.environment}/s3.tfstate"
    region         = "us-east-1"   # <<< same region your bucket is in
    encrypt        = true
    dynamodb_table = "terraform-state-lock"  # optional locking table
  }
}

inputs = {
  # whatever inputs your s3 module needs
}
