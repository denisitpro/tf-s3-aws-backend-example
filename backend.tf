terraform {
  backend "s3" {
    bucket         = "s3-state-backend-v1"
    key            = "v1/aws-state-backend-euc1-v1.tfstate"
    region         = "eu-central-1"
    profile        = "aws_state_backend_s3_rw"
    encrypt        = true
    dynamodb_table = "aws_state_backend_euc1_v1_locks"
  }
}
