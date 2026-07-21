resource "google_container_cluster" "gke" {

  provider = google-beta

  name     = "${var.environment}-gke"

  location = var.region

  project  = var.project_id

  network    = var.network

  subnetwork = var.subnetwork

  remove_default_node_pool = true

  initial_node_count = 1

  networking_mode = "VPC_NATIVE"

  deletion_protection = false

  release_channel {

    channel = "REGULAR"

  }

  workload_identity_config {

    workload_pool = "${var.project_id}.svc.id.goog"

  }

  private_cluster_config {

    enable_private_nodes = true

    enable_private_endpoint = false

    master_ipv4_cidr_block = "172.16.0.0/28"

  }

  ip_allocation_policy {

    cluster_secondary_range_name  = var.pods_range_name

    services_secondary_range_name = var.services_range_name

  }

  network_policy {

    enabled = true

  }

  logging_service = "logging.googleapis.com/kubernetes"

  monitoring_service = "monitoring.googleapis.com/kubernetes"

}



resource "google_container_node_pool" "primary" {

  name = "${var.environment}-nodepool"

  cluster = google_container_cluster.gke.name

  location = var.region

  project = var.project_id

  initial_node_count = 2

  autoscaling {

    min_node_count = 2

    max_node_count = 6

  }

  management {

    auto_repair = true

    auto_upgrade = true

  }

  node_config {

    machine_type = "e2-standard-2"

    disk_size_gb = 50

    disk_type = "pd-balanced"

    image_type = "COS_CONTAINERD"

    preemptible = false

    shielded_instance_config {

      enable_secure_boot = true

      enable_integrity_monitoring = true

    }

    oauth_scopes = [

      "https://www.googleapis.com/auth/cloud-platform"

    ]

  }

}
