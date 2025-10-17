terraform {
  source = "../../../modules/s3"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name = "abidem1-terragrunt-demo-bucket"
}
