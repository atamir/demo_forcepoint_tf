terraform {
  backend "s3" {
    bucket                 = "terraform-state-for-demos" # Replace with your bucket name
    key                    = "state.tfstate.demos"
    region                 = "il-central-1"
    dynamodb_table         = "terraform-state-locks"
    encrypt                = true
    skip_region_validation = true
    }
}
