provider "aws" {
  region = "eu-central-1"
  profile = "aws_state"

  default_tags {
    tags = {
      Code       = "company_code"
      Stand      = "devel"
      Region     = "eu-central-1"
      Generation = "gen1"
      Location   = "Frankfurt"
      ManagedBy = "Terraform"
    }
  }
}