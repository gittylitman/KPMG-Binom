variable "region" {
    type = string
}

variable "runtime" {
  type = string 
}

variable "cloud_function_automation_name" {
  type = string
}

variable "automation_function_entry_point" {
  type = string
}

variable "bucket_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_object_name" {
  type = string
}

variable "event_type" {
  type = string
  default = "google.storage.object.finalize"
}
