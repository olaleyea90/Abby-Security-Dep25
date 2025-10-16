############################
# Remote state (dev)
############################

# ---- Pick a UNIQUE bucket name (global) ----
# Update this string to a unique, readable name.
# Example: abby-deploy-state-dev-01  (letters, numbers, hyphens only)
variable "state_bucket_name" {
  type        = string
  description = "Globally-unique S3 bucket name for Terraform state."
  default     = "abby-deploy-state-dev-01"
}

# ---- S3 bucket for state ----
resource "aws_s3_bucket" "state" {
  bucket = var.state_bucket_name

  tags = {
    Name        = "tf-state-dev"
    Environment = "Dev"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "state" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versioning for recoverability
resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Enforce TLS
data "aws_iam_policy_document" "state_tls" {
  statement {
    sid     = "DenyInsecureTransport"
    effect  = "Deny"
    actions = ["s3:*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      aws_s3_bucket.state.arn,
      "${aws_s3_bucket.state.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "state" {
  bucket = aws_s3_bucket.state.id
  policy = data.aws_iam_policy_document.state_tls.json
}

# ---- DynamoDB table for state locking ----
resource "aws_dynamodb_table" "tf_lock_table" {
  name         = "terraform-locks-dev"   # no spaces/() allowed
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "tf-locks-dev"  # no spaces/() here either
    Environment = "Dev"
  }
}

############################
# Outputs
############################
output "state_bucket_name" {
  value       = aws_s3_bucket.state.bucket
  description = "S3 bucket name for Terraform remote state."
}

output "lock_table_name" {
  value       = aws_dynamodb_table.tf_lock_table.name
  description = "DynamoDB table name for Terraform state locking."
}
