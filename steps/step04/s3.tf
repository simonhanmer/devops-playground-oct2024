resource "aws_s3_bucket" "fis_config_bucket" {
  bucket = replace("${data.aws_caller_identity.current.account_id}_${data.aws_region.current.name}_${var.panda_name}_fis_config_bucket", "_", "-")
  # empty bucket on delete
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.fis_config_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
