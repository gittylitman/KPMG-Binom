resource "google_project_service" "cloudresourcemanager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "firestore" {
  service = "firestore.googleapis.com"
  disable_on_destroy = false 
}

resource "google_firestore_database" "firestore_database" {
  name                              = var.name
  location_id                       = var.location
  type                              = "FIRESTORE_NATIVE"
  app_engine_integration_mode       = "DISABLED"
  deletion_policy                   = "DELETE"
  depends_on = [
    google_project_service.cloudresourcemanager,
    google_project_service.firestore
  ]
}

resource "google_firestore_document" "documents"{
  database = google_firestore_database.firestore_database.name
  collection = var.table_name[count.index]
  document_id = var.table_name[count.index]
  fields = ""
  count = length(var.table_name)
}
