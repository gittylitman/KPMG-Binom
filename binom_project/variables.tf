variable "project_id" {
  type = string
  default = "dgt-gcp-cgov-t-binom"
}

variable "host_project_id" {
  type = string
  default = "dgt-gcp-cgov-net-office-0"
}

variable "project_name" {
  type = string
  default = "binom"
}

variable "environment" {
  type = string
  default = "test"
}

variable "region" {
  type = string
  default = "me-west1"
}

# windows vm module

variable "zone_part" {
  type = string
  default = "a"
}

# document AI module

variable "document_ai_location" {
  type = string
  default = "eu"
}

# firestore module

variable "tables_name" {
  type = list(string)
  default = [ "results", "summaries", "activity", "console"]
}

# cloud storages module

variable "cloud_storage_names" {
  type = list(string)
  default = [ "gcs-source", "gcs" ]
}

# object module

variable "bucket_object_names" {
  type = list(string)
  default = ["bs-result" ,"bs-summary","automation"]
}

variable "bucket_object_sources" {
  type = list(string)
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
  default = ["neg-getresult", "neg-getsummary"]
}

variable "backend_services_names" {
  type = list(string)
  default = ["back-getresult", "back-getsummary"]
}
