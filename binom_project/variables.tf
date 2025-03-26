variable "project_id" {
  type = string
  default = "gantt-service-project"
}

variable "host_project_id" {
  type = string
  default = "gantt-host-project"
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
  default = "binom-dev"
}

variable "subnet_name" {
  type = string
  default = "snet-test-binom"
}

variable "subnet_proxy_name" {
  type = string
  default = "snet-test-proxy-only-binom"
}

variable "connector_name" {
  type = string
  default = "binom-test-serverless-vpc"
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
  default = [ "us-docker.pkg.dev/cloudrun/container/hello", "us-docker.pkg.dev/cloudrun/container/hello" ]
}

# module eventarc trigger

variable "cloud_run_automation_name" {
  type = string
  default = "automation"
}

variable "automation_container_image" {
  type = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}

# module load balancer

variable "certificate_secret_name" {
  type = string
  default = "certificate"
}

variable "private_key_secret_name" {
  type = string
  default = "priavte-key"
}

variable "neg_names" {
  type = list(string)
  default = ["neg-getresult", "neg-getsummary"]
}

variable "backend_services_names" {
  type = list(string)
  default = ["back-getresult", "back-getsummary"]
}
