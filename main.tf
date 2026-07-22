module "network" {
  source = "./modules/network"

  project_id = var.project_id
  region      = var.region
  environment = var.environment

  vpc_cidr      = "10.10.0.0/16"
  subnet_cidr   = "10.10.1.0/24"
  pods_cidr     = "10.20.0.0/16"
  services_cidr = "10.30.0.0/20"
}



module "gke" {

  source = "./modules/gke"

  project_id = var.project_id

  region = var.region

  environment = var.environment

  network = module.network.vpc_id

  subnetwork = module.network.subnet_self_link

  pods_range_name = module.network.pods_range_name

  services_range_name = module.network.services_range_name

  node_service_account = module.iam.gke_service_account_email

}



module "iam" {
  source = "./modules/iam"

  project_id = var.project_id
  environment = var.environment
}
