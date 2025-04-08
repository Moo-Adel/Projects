resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-lab3-terraform-state" # Must be globally unique!

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "dev"
  }
}

terraform {
  backend "s3" {
    bucket = "my-lab3-terraform-state"
    key    = "state/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
