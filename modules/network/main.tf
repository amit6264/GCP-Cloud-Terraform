resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-vpc"
  project                 = var.project_id

  auto_create_subnetworks = false

  routing_mode = "GLOBAL"

  mtu = 1460
}


resource "google_compute_subnetwork" "private" {

  name          = "${var.environment}-private-subnet"

  project       = var.project_id

  region        = var.region

  network       = google_compute_network.vpc.id

  ip_cidr_range = var.subnet_cidr

  private_ip_google_access = true

  secondary_ip_range {

    range_name    = "pods"

    ip_cidr_range = var.pods_cidr

  }

  secondary_ip_range {

    range_name    = "services"

    ip_cidr_range = var.services_cidr

  }

}




resource "google_compute_router" "router" {

  name = "${var.environment}-router"

  project = var.project_id

  region = var.region

  network = google_compute_network.vpc.id

}




resource "google_compute_router_nat" "nat" {

  name = "${var.environment}-nat"

  project = var.project_id

  router = google_compute_router.router.name

  region = var.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {

    enable = true

    filter = "ERRORS_ONLY"

  }

}




resource "google_compute_firewall" "internal" {

  name = "${var.environment}-allow-internal"

  network = google_compute_network.vpc.name

  project = var.project_id

  source_ranges = [
    var.vpc_cidr,
    var.pods_cidr,
    var.services_cidr
  ]

  allow {

    protocol = "tcp"

  }

  allow {

    protocol = "udp"

  }

  allow {

    protocol = "icmp"

  }

}





resource "google_compute_firewall" "healthcheck" {

  name = "${var.environment}-health-check"

  network = google_compute_network.vpc.name

  project = var.project_id

  source_ranges = [

    "35.191.0.0/16",

    "130.211.0.0/22"

  ]

  allow {

    protocol = "tcp"

  }

}




resource "google_compute_firewall" "iap_ssh" {

  name = "${var.environment}-iap-ssh"

  network = google_compute_network.vpc.name

  project = var.project_id

  source_ranges = [
    "35.235.240.0/20"
  ]

  allow {

    protocol = "tcp"

    ports = ["22"]

  }

}
