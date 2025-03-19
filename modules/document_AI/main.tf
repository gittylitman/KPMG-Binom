resource "google_project_service" "cloud_resource_manager"{
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "documentai" {
  project = var.project_id
  service            = "documentai.googleapis.com"
  disable_on_destroy = false
  depends_on = [ google_project_service.cloud_resource_manager ]
}

resource "google_document_ai_processor" "processor" {
  location = var.location
  display_name = var.name
  type = var.type
  depends_on = [ google_project_service.documentai ]
}
