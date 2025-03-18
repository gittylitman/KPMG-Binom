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
  vpc_name = var.environment
  subnetwork_name = "snet-${var.environment}-${var.project_name}"
  region = var.region
  host_project_id = var.host_project_id
}

module "windows_vm" {
  source = "../modules/windows_vm"
  service_account_vm_name = "${var.project_name}-sa-vm-${var.environment}"
  zone = "${var.region}-${var.zone_part}"
  vm_name = "${var.project_name}-vm-${var.environment}"
  network_name = module.network.network_name
  subnetwork_name = module.network.subnet_name
}

module "document_ai" {
  source = "../modules/document_AI"
  location = var.document_ai_location
  name = "${var.project_name}-document-ai-${var.environment}"
}

module "firestore" {
  source = "../modules/firestore"
  name = "${var.project_name}-firestore-${var.environment}"
  location = var.region
  table_name = var.tables_name
}

module "cloud_storages" {
  source = "../modules/cloud_storage"
  name = "${var.project_name}-${var.cloud_storage_names[count.index]}-${var.environment}"
  location = var.region
  count = length(var.cloud_storage_names)
}

module "object" {
  source = "../modules/bucket_object"
  bucket_name = module.cloud_storages[0].bucket_name
  bucket_object_name = var.bucket_object_names[count.index]
  bucket_storage_source = var.bucket_object_sources[count.index]
  count  = length(var.bucket_object_names)
}

module "https_trigger_cloud_function" {
  source = "../modules/https_trigger_cloud_function"
  region = var.region
  runtime = var.runtime
  cloud_function_https_name = var.cloud_function_https_names[count.index]
  https_function_entry_point = var.https_function_entry_points[count.index]
  bucket_name = module.cloud_storages[0].bucket_name
  bucket_object_name = module.object[count.index].bucket_object_name
  count   =   length(var.cloud_function_https_names)
}

module "storage_trigger_cloud_function" {
  source = "../modules/storage_trigger_cloud_function"
  region = var.region
  runtime = var.runtime
  cloud_function_automation_name = var.cloud_function_automation_name
  automation_function_entry_point = var.automation_function_entry_point
  bucket_id = module.cloud_storages[1].bucket_id
  bucket_name = module.cloud_storages[0].bucket_name
  bucket_object_name = module.object[2].bucket_object_name
}

module "load_balancer" {
  source = "../modules/internal_load_balancer"
  region = var.region
  cloud_run_names = var.cloud_function_https_names
  neg_name = ["${var.project_name}-${var.neg_names[0]}-${var.environment}", "${var.project_name}-${var.neg_names[1]}-${var.environment}"]
  backend_service_name = ["${var.project_name}-${var.backend_services_names[0]}-${var.environment}", "${var.project_name}-${var.backend_services_names[1]}-${var.environment}"]
  lb_name = "${var.project_name}-lb-${var.environment}"
  cert_name = "${var.project_name}-cert-${var.environment}"
  https_proxy_name = "${var.project_name}-proxy-${var.environment}"
  https_forwarding_rule_name = "${var.project_name}-forwarding-rule-${var.environment}"
  subnetwork = module.network.subnet_name
  network = module.network.network_name
  subnet_proxy_name = "${var.project_name}-snet-proxy-${var.environment}"
  host_project_id = var.host_project_id
}
