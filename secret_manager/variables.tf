variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
  default = "binom"
}

variable "environment" {
  type = string
  default = "d-i"
}

variable "secret_id" {
  type = list(string)
  default = [ "certificate", "private-key" ]
}

variable "location" {
  type = string
  default = "me-west1"
}
