locals {
  environment = "prod"          # <-- add this
}

remote_state {
  backend = "s3"
  config = {
    bucket = "abileye-newbucket-prod"
    key    = "${local.environment}/iam_user.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
