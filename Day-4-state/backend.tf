terraform {
  backend "s3" {
    bucket  = "teraform-demo-state"
    key     = "day-4/terraform.tfstate"
    region  = "us-east-1"
    profile = "dev"

    use_lockfile = true
  }
}
