resource "google_storage_bucket" "storage_bucket" {
  name = var.name
  location = var.location
  uniform_bucket_level_access = true
}
