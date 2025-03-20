resource "google_project_service" "cloudresourcemanager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "cloudfunctions" {
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}
resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [
    google_project_service.cloudresourcemanager,
    google_project_service.cloudfunctions,
    google_project_service.cloudbuild,
    google_project_service.compute
  ]

  create_duration = "90s"
}
