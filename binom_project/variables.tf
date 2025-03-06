variable "project_id" {
  type = string
  default = "kpng-shechter"
}

variable "project_name" {
  type = string
  default = "binom"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
  default = "me-west1"
}

variable "region_cloud_functions" {
  type = string
  default = "us-central1"
}

# network module

variable "vpc_name" {
  type = string
  default = "vpc-dev-binom"
}

variable "subnet_name" {
  type = string
  default = "snet-dev-binom"
}

variable "ip_cidr_range" {
  type = string
  default = "100.69.0.112/28"
}

# windows vm module

variable "service_account_vm_name" {
  type = string
  default = "sa-vm-dev-binom"
}

variable "zone_part" {
  type = string
  default = "a"
}

variable "vm_name" {
  type = string
  default = "vm-dev-binom"
}

# document AI module

variable "document_ai_name" {
  type = string
  default = "document-ai-dev-binom"
}

variable "document_ai_location" {
  type = string
  default = "eu"
}

# firestore module

variable "firestore_name" {
  type = string
  default = "firestore-dev-binom"
}

variable "tables_name" {
  type = list(string)
  default = [ "results", "summaries", "activity", "console"]
}

# cloud storages module

variable "cloud_storage_names" {
  type = list(string)
  default = [ "gcs-source-dev-binom", "gcs-dev-binom" ]
}

# object module

variable "bucket_object_names" {
  type = list(string)
  default = ["bs-result" ,"bs-summary","automation"]
}

variable "bucket_object_sources" {
  type = list(string)
  default = [
    "../services_getresult_1741077250.383000.zip",
    "../services_getresult_1741077250.383000.zip",
    "../services_automation_1741077172.506000.zip"
  ]
}

# cloud_function modules

variable "runtime" {
  type = string
  default = "python39"
}

# https_trigger_cloud_function module

variable "cloud_function_https_names" {
  type = list(string)
  default = [ "get-result","get-summary" ]
}

variable "https_function_entry_points" {
  type = list(string)
  default = [ "getResult" ,"getResult" ]
}

# storage_trigger_cloud_function

variable "cloud_function_automation_name" {
  type = string
  default = "automation"
}

variable "automation_function_entry_point" {
  type = string
  default = "hello_gcs"
}

# module load balancer

variable "neg_names" {
  type = list(string)
  default = ["neg-getresult-dev-binom", "neg-getsummary-dev-binom"]
}

variable "backend_services_names" {
  type = list(string)
  default = ["back-getresult-dev-binom", "back-getsummary-dev-binom"]
}

variable "lb_name" {
  type = string
  default = "lb-dev-binom"
}

variable "cert_name" {
  type = string
  default = "cert-dev-binom"
}

variable "cert_file" {
  type = string
  default = "./certificate.pem"
}

variable "private_key_file" {
  type = string
  default = "./private_key.pem"
}

variable "https_proxy_name" {
  type = string
  default = "proxy-dev-binom"
}

variable "https_forwarding_rule_name" {
  type = string
  default = "forwarding-rule-dev-binom"
}

variable "subnet_proxy_name" {
  type = string
  default = "snet-proxy-dev-binom"
}

variable "ip_range" {
  type = string
  default = "100.69.1.112/28"
}

