terraform {
  backend "s3" {
    bucket  = "teraform-demo-state"
    key     = "day-5/terraform.tfstate"
    region  = "us-east-1"
    profile = "dev"

    # use_lockfile = true 

    dynamodb_table = "terraform-state-lock-dynamo"

  }
}
