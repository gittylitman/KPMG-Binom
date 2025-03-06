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

module "cloud_storages" {
  source = "../modules/cloud_storage"
  name = var.cloud_storage_names[count.index]
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
  region = var.region_cloud_functions
  runtime = var.runtime
  cloud_function_https_name = var.cloud_function_https_names[count.index]
  https_function_entry_point = var.https_function_entry_points[count.index]
  bucket_name = module.cloud_storages[0].bucket_name
  bucket_object_name = module.object[count.index].bucket_object_name
  count   =   length(var.cloud_function_https_names)
}

module "storage_trigger_cloud_function" {
  source = "../modules/storage_trigger_cloud_function"
  region = var.region_cloud_functions
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
  neg_name = var.neg_names
  backend_service_name = var.backend_services_names
  lb_name = var.lb_name
  cert_name = var.cert_name
  cert_file = var.cert_file
  private_key_file = var.private_key_file
  https_proxy_name = var.https_proxy_name
  https_forwarding_rule_name = var.https_forwarding_rule_name
  subnetwork = module.network.subnet_name
  network = module.network.network_name
  depends_on = [ module.https_trigger_cloud_run ]
}
