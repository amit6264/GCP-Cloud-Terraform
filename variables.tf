variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Deployment Region"
  type        = string
}

variable "zone" {
  description = "Primary Zone"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}
