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
  value = google_compute_subnetwork.private.secondary_ip_range[0].range_name
}

output "services_range_name" {
  value = google_compute_subnetwork.private.secondary_ip_range[1].range_name
}
