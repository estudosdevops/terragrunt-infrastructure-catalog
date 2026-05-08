# -----------------------------------------------------------------------------
# Unit: AWS S3 Bucket
# Módulo base: terraform-aws-modules/s3-bucket/aws v4.2.1
#
# Mantido pelo time de Platform.
# Os inputs chegam via values do terragrunt.stack.hcl do live.
# -----------------------------------------------------------------------------

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/s3-bucket/aws?version=4.2.1"
}

inputs = {
  bucket        = values.name
  force_destroy = values.force_destroy

  versioning = {
    enabled = values.versioning
  }

  lifecycle_rule = try(values.expire_noncurrent_days, 0) > 0 ? [
    {
      id      = "expire-noncurrent-versions"
      enabled = true
      noncurrent_version_expiration = {
        noncurrent_days = values.expire_noncurrent_days
      }
    }
  ] : []

  # Segurança mínima — sempre habilitado, não exposto ao Dev
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}
