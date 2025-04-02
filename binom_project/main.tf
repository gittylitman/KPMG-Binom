terraform {
  backend "gcs" {
    bucket  = "<name of bucket>"
    prefix  = "state"
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service" "cloudresourcemanager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

module "network" {
  source = "../modules/network"
  vpc_name = var.vpc_name
  subnetwork_name = var.subnet_name
  region = var.region
  host_project_id = var.host_project_id
  depends_on = [ google_project_service.cloudresourcemanager ]
}

module "windows_vm" {
  source = "../modules/windows_vm"
  service_account_vm_name = "${var.project_name}-sa-vm-${var.environment}"
  zone = "${var.region}-${var.zone_part}"
  vm_name = "${var.project_name}-vm-${var.environment}"
  network_id = module.network.network_id
  subnetwork_id = module.network.subnet_id
}

module "document_ai" {
  source = "../modules/document_AI"
  location = var.document_ai_location
  name = "${var.project_name}-document-ai-${var.environment}"
  depends_on = [ module.network ]
}

module "firestore" {
  source = "../modules/firestore"
  name = "${var.project_name}-firestore-${var.environment}"
  location = var.region
  table_name = var.tables_name
  depends_on = [ module.network ]
}

module "cloud_storage" {
  source = "../modules/cloud_storage"
  name = "${var.project_name}-${var.cloud_storage_name}-${var.environment}"
  location = var.region
  depends_on = [ module.network ]
}

module "cloud_run" {
  source = "../modules/https_cloud_run"
  cloud_run_name = var.https_cloud_run_names[count.index]
  location = var.region
  container_image = var.https_container_images[count.index]
  connector_name = var.connector_name
  host_project_id = var.host_project_id
  count = length(var.https_cloud_run_names)
  depends_on = [ module.network ]
}

module "eventarc_trigger" {
  source = "../modules/eventarc_trigger"
  sa_eventarc_name = "${var.project_name}-sa-eventarc-${var.environment}"
  cloud_run_name = var.cloud_run_automation_name
  location = var.region
  container_image = var.automation_container_image
  trigger_name = "${var.project_name}-trigger-${var.environment}"
  cloud_storage_name = module.cloud_storage.bucket_name
  connector_name = var.connector_name
  host_project_id = var.host_project_id
}

module "load_balancer" {
  source = "../modules/internal_load_balancer"
  region = var.region
  certificate_secret_name = var.certificate_secret_name
  private_key_secret_name = var.private_key_secret_name
  cloud_run_names = var.https_cloud_run_names
  neg_name = ["${var.project_name}-${var.neg_names[0]}-${var.environment}", "${var.project_name}-${var.neg_names[1]}-${var.environment}"]
  backend_service_name = ["${var.project_name}-${var.backend_services_names[0]}-${var.environment}", "${var.project_name}-${var.backend_services_names[1]}-${var.environment}"]
  lb_name = "${var.project_name}-lb-${var.environment}"
  cert_name = "${var.project_name}-cert-${var.environment}"
  https_proxy_name = "${var.project_name}-proxy-${var.environment}"
  https_forwarding_rule_name = "${var.project_name}-forwarding-rule-${var.environment}"
  subnetwork = module.network.subnet_id
  network = module.network.network_id
  subnet_proxy_name = var.subnet_proxy_name
  host_project_id = var.host_project_id

  depends_on = [ module.cloud_run ]
}
