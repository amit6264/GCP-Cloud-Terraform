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
