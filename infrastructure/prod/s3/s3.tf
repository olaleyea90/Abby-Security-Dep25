resource "aws_s3_bucket" "dynamic_abby_16" {
  bucket = "dynamic-abby-16"
  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "dynamic_abby_16" {
  bucket = aws_s3_bucket.dynamic_abby_16.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "deny_deletes_without_mfa" {
  statement {
    sid    = "DenyDeletesWithoutMFA"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:DeleteObject",
      "s3:DeleteObjectVersion"
    ]

    resources = [
      aws_s3_bucket.dynamic_abby_16.arn,
      "${aws_s3_bucket.dynamic_abby_16.arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "mfa_delete_guard" {
  bucket = aws_s3_bucket.dynamic_abby_16.id
  policy = data.aws_iam_policy_document.deny_deletes_without_mfa.json
}
