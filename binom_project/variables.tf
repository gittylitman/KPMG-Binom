variable "project_id" {
  type = string
}

variable "host_project_id" {
  type = string
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

# network module

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_proxy_name" {
  type = string
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

variable "cloud_storage_name" {
  type = string
  default = "gcs"
}

# https_trigger_cloud_run module

variable "https_cloud_run_names" {
  type = list(string)
  default = [ "get-result","get-summary" ]
}

variable "https_container_images" {
  type = list(string)
}

# module eventarc trigger

variable "cloud_run_automation_name" {
  type = string
  default = "automation"
}

variable "automation_container_image" {
  type = string
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

variable "certificate_name" {
  type = string
}
