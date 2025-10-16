# Root Terragrunt config for Abby-Security-Dep25

remote_state {
  backend = "s3"
  config = {
    bucket         = "abby-prod-config-logs-qn39w9"   # your bucket
    key            = "state/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    # optional but harmless:
    s3_force_path_style      = true
    skip_credentials_validation = false
  }
}

# (Optional) shared inputs
inputs = {
  project = "abby-security-dep25"
}
