resource "google_storage_bucket_object" "archive" {
  count  = length(var.bucket_object_name)
  name   = var.bucket_object_name[count.index]
  bucket = var.bucket_name
  source = var.bucket_storage_source[count.index]
}
