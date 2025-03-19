resource "google_project_service" "documentai" {
  service            = "documentai.googleapis.com"
  disable_on_destroy = false
}

resource "google_document_ai_processor" "processor" {
  location = var.location
  display_name = var.name
  type = var.type
  depends_on = [ google_project_service.documentai ]
}
