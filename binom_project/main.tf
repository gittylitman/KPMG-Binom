terraform {
  backend "gcs" {
    bucket  = "terraform-binom"
    prefix  = "state"
  }
}

provider "google" {
  project = var.project_id
}

module "network" {
  source = "../modules/network"
  vpc_name = var.vpc_name
  subnetwork_name = var.subnet_name
  region = var.region
  ip_cidr_range = var.ip_cidr_range
}

module "windows_vm" {
  source = "../modules/windows_vm"
  service_account_vm_name = var.service_account_vm_name
  zone = "${var.region}-${var.zone_part}"
  vm_name = var.vm_name
  network_name = module.network.network_name
  subnetwork_name = module.network.subnet_name
}

module "document_ai" {
  source = "../modules/document_AI"
  location = var.document_ai_location
  name = var.document_ai_name
}

module "firestore" {
  source = "../modules/firestore"
  name = var.firestore_name
  location = var.region
  table_name = var.tables_name
}
