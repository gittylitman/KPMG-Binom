variable "bucket_name" {
  type = string
}

variable "bucket_object_name" {
  type = list(string)
}

variable "bucket_storage_source" {
  type = list(string)
}
