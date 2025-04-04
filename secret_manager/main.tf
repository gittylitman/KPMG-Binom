terraform {
  backend "gcs" {
    bucket  = "secret-manager-binom"
    prefix  = "state"
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service" "serviceusage" {
  service            = "serviceusage.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "secretmanager" {
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
  depends_on = [ google_project_service.serviceusage ]
}

resource "google_secret_manager_regional_secret" "secret" {
  secret_id = var.secret_id[count.index]
  location = var.location
  count = length(var.secret_id)
  depends_on = [ google_project_service.secretmanager ]
}
