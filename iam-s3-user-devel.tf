# Create an IAM user
resource "aws_iam_user" "s3_devel_euc1_rw" {
  name = "s3-devel-euc1-rw"
  tags = {
    Name      = "euc1-${var.stand_code} for devel-euc1-s3-user"
    Createdby = "username"
    Owner     = "username"
  }
}

# Create an IAM policy for S3 access to the specific bucket
resource "aws_iam_policy" "s3_policy_devel_euc1_rw" {
  name = "s3-devel-euc1-access-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:ListBucket"],
      Resource = [
        aws_s3_bucket.s3_backend_devel_euc1.arn
      ]
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = [
          join("/", [aws_s3_bucket.s3_backend_devel_euc1.arn, "*"])
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
        ],
        Resource = [
          aws_dynamodb_table.dynamodb_devel_euc1_g1.arn
        ]
      }
    ]
  })
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "s3_policy_attch_devel_euc1_rw" {
  user       = aws_iam_user.s3_devel_euc1_rw.name
  policy_arn = aws_iam_policy.s3_policy_devel_euc1_rw.arn
}

