resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region
}

resource "google_storage_bucket_object" "archive" {
  count  = length(var.bucket_object_name)
  name   = var.bucket_object_name[count.index]
  bucket = google_storage_bucket.bucket.name
  source = var.bucket_storage_source[count.index]
}

resource "google_cloudfunctions_function" "https_triger_function" {
  count   =   length(var.cloud_function_https_name)
  name        = var.cloud_function_https_name[count.index]
  region = var.region
  runtime     = var.runtime
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = var.bucket_object_name[count.index]
  trigger_http          = true
  entry_point           = var.https_function_entry_point[count.index]
}

resource "google_cloudfunctions_function" "storage_trigg_function" {
  name                    = var.cloud_function_automation_name
  region                  = var.region
  runtime                 = var.runtime
  source_archive_bucket    = google_storage_bucket.bucket.name
  source_archive_object    = var.bucket_object_name[2]
  entry_point             = var.automation_function_entry_point

  event_trigger {
    event_type = var.event_type
    resource   = google_storage_bucket.bucket.id
  }
}