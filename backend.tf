terraform {
  backend "gcs" {
    bucket = "terraform-state-prod"
    prefix = "gke/terraform.tfstate"
  }
}
