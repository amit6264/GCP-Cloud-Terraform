locals {
  name_prefix = "${var.environment}-gke"

  common_labels = {
    environment = var.environment
    managed_by  = "terraform"
    project      = "shopping"
  }
}
