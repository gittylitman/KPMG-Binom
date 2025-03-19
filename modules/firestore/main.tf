resource "google_project_service" "cloud_resource_manager"{
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "firestore" {
  project = var.project_id
  service = "firestore.googleapis.com"
  disable_on_destroy = false 
  depends_on = [ google_project_service.cloud_resource_manager ]
}

resource "google_firestore_database" "firestore_database" {
  name                              = var.name
  location_id                       = var.location
  type                              = "FIRESTORE_NATIVE"
  app_engine_integration_mode       = "DISABLED"
  deletion_policy                   = "DELETE"
  depends_on = [google_project_service.firestore]
}

resource "google_firestore_document" "documents"{
  database = google_firestore_database.firestore_database.name
  collection = var.table_name[count.index]
  document_id = var.table_name[count.index]
  fields = ""
  count = length(var.table_name)
}
