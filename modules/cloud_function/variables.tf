variable "region" {
    type = string
}

variable "runtime" {
  type = string 
}

variable "cloud_function_https_name" {
  type = list(string)
}

variable "cloud_function_automation_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_object_name" {
  type = list(string)
}

variable "bucket_storage_source" {
  type = list(string)
}

variable "https_function_entry_point" {
  type = list(string)
}

variable "automation_function_entry_point" {
  type = string
}

variable "event_type" {
  type = string
}







