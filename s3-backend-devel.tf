resource "aws_s3_bucket" "s3_backend_devel_euc1" {
  bucket = "s3-backend-devel-g1"
  lifecycle {
    prevent_destroy = true # bucket can't be destoroyed
  }
  tags = {
    Name      = "euc1-${var.stand_code} bucket devel-euc1-g1"
    Createdby = "username"
    Owner     = "username"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership_devel_euc1_g1" {
  bucket = aws_s3_bucket.s3_backend_devel_euc1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_acl_devel_euc1_g1" {
  bucket = aws_s3_bucket.s3_backend_devel_euc1.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.s3_ownership_devel_euc1_g1]
}


resource "aws_s3_bucket_versioning" "s3_versioning_devel_euc1_g1" {
  bucket = aws_s3_bucket.s3_backend_devel_euc1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse_devel_euc1_g1" {
  bucket = aws_s3_bucket.s3_backend_devel_euc1.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}


#resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle_devel_euc1_g1" {
#  bucket = aws_s3_bucket.s3_backend_devel_euc1.id
#
#  rule {
#    id = "versioning-policy"
#
#    status = "Enabled"
#    transition {
#      days          = 360
#      storage_class = "STANDARD_IA"
#    }
#    #    transition {
#    #      days          = 60
#    #      storage_class = "GLACIER"
#    #    }
#    expiration {
#      days = 90
#    }
#  }
#}

resource "aws_dynamodb_table" "dynamodb_devel_euc1_g1" {
  name         = "devel_euc1_v1_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

#output "dynamodb_table_arn" {
#  value = aws_dynamodb_table.dynamodb_devel_euc1_g1.arn
#}
