output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.private.name
}

output "subnet_self_link" {
  value = google_compute_subnetwork.private.self_link
}

output "pods_range_name" {
  value = "pods"
}

output "services_range_name" {
  value = "services"
}
