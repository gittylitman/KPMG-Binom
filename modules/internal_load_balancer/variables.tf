variable "region" {
  type = string
}

variable "cloud_run_names" {
  type = list(string)
}

variable "neg_name" {
    type = list(string)
}

variable "backend_service_name" {
  type = list(string)
}

variable "lb_name" {
  type = string
}

variable "cert_name" {
  type = string
}

variable "https_proxy_name" {
    type = string
}

variable "https_forwarding_rule_name" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "network" {
  type = string
}

variable "subnet_proxy_name" {
  type = string
}

variable "host_project_id" {
  type = string
}