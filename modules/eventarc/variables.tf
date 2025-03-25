variable "trigger_name" {
  type = string
}

variable "cloud_run_location" {
  type = string
}

variable "storage_bucket_name" {
  type = string
}

variable "cloud_run_name" {
  type = string
}

variable "service_account" {
  type = string
}

variable "event_type" {
  type = string
  default = "google.cloud.storage.object.v1.finalized"
}
