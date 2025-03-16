resource "google_cloudfunctions_function" "https_trigger_function" {
  name = var.cloud_function_https_name
  region = var.region
  runtime = var.runtime
  source_archive_bucket = var.bucket_name
  source_archive_object = var.bucket_object_name
  trigger_http = true
  entry_point = var.https_function_entry_point
}
