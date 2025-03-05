
resource "google_document_ai_processor" "processor" {
  location = var.location
  display_name = var.name
  type = var.type
}

output "processor_id" {
  value = google_document_ai_processor.processor.id
}