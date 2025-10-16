# Root Terragrunt config (parent)
remote_state {
  backend = "s3"
  generate = {
    path      = "zz_remote_backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "abby-prod-config-logs-qn39w9"
    key            = "state/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

inputs = {
  project = "cloud-security-deployment"
}
