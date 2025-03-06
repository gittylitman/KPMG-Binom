variable "project_id" {
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
}

variable "zone_part" {
  type = string
  default = "a"
}

variable "vm_name" {
  type = string
}

# document AI module

variable "document_ai_name" {
  type = string
}

variable "document_ai_location" {
  type = string
  default = "eu"
}

# firestore module

variable "firestore_name" {
  type = string
}

variable "tables_name" {
  type = list(string)
  default = [ "results", "summaries", "activity", "console"]
}
