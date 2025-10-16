cat > terragrunt.hcl <<'EOF'
# Root Terragrunt config (LOCAL state to keep it simple)
# You can later switch to S3/DynamoDB by adding a remote_state block here.

# Shared inputs for all environments (optional)
inputs = {
  project = "cloud-security-deployment"
}
EOF
