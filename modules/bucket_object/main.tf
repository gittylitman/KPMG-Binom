resource "google_storage_bucket_object" "archive" {
  name   = var.bucket_object_name
  bucket = var.bucket_name
  source = var.bucket_storage_source
}
