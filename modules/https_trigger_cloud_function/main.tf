resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudfunctions" {
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_cloudfunctions_function" "https_trigger_function" {
  name = var.cloud_function_https_name
  region = var.region
  runtime = var.runtime
  source_archive_bucket = var.bucket_name
  source_archive_object = var.bucket_object_name
  trigger_http = true
  entry_point = var.https_function_entry_point
  depends_on = [ 
    google_project_service.cloudbuild,
    google_project_service.cloudfunctions 
  ]
}
