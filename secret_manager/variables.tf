variable "project_id" {
  type = string
  default = "binom-project"
}

variable "secret_id" {
  type = list(string)
  default = [ "certificate", "private_key" ]
}

variable "location" {
  type = string
  default = "me-west1"
}
