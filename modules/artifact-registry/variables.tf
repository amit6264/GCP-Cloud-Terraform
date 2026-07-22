variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "repository_name" {
  type    = string
  default = "gke-images"
}
