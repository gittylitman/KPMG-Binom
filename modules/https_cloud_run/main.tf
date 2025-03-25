resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_cloud_run_v2_service" "cloud_run"{
  name = var.cloud_run_name
  location = var.location
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  deletion_protection = false
  template {
    containers {
      ports {
        container_port = 80
      }
      image = var.container_image
    }
  }

  depends_on = [ google_project_service.run ]
}
