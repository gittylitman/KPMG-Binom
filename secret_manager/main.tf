terraform {
  backend "gcs" {
    bucket  = "secret-manager-binom"
    prefix  = "state"
  }
}

provider "google" {
  project = var.project_id
}

resource "google_secret_manager_regional_secret" "secret" {
  secret_id = var.secret_id
  location = var.location
}
