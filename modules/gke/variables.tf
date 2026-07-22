variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "pods_range_name" {
  type = string
}

variable "services_range_name" {
  type = string
}





variable "node_service_account" {
  type = string
}


node_config {
  service_account = var.node_service_account

  machine_type = "e2-standard-2"
  disk_size_gb = 50
  disk_type    = "pd-balanced"
  image_type   = "COS_CONTAINERD"

  shielded_instance_config {
    enable_secure_boot          = true
    enable_integrity_monitoring = true
  }

  oauth_scopes = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write"
  ]
}
