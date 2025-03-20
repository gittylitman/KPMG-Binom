resource "google_compute_network" "vpc_network" {
  name         = var.vpc_name
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  purpose = "PRIVATE"
}
