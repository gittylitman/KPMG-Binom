resource "google_cloudfunctions_function" "https_triger_function" {
  count   =   length(var.cloud_function_https_name)
  name        = var.cloud_function_https_name[count.index]
  region = var.region
  runtime     = var.runtime
  source_archive_bucket = var.bucket_name
  source_archive_object = var.bucket_object_name[count.index]
  trigger_http          = true
  entry_point           = var.https_function_entry_point[count.index]
}
