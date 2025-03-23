resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s"
  depends_on = [ google_project_service.compute ]
}

data "google_compute_network" "vpc_network" {
  name         = var.vpc_name
  project = var.host_project_id
  depends_on = [ time_sleep.wait_60_seconds ]
}

data "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  region        = var.region
  project = var.host_project_id
}
