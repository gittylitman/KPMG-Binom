resource "google_cloudfunctions_function" "storage_trigger_function" {
  name                    = var.cloud_function_automation_name
  region                  = var.region
  runtime                 = var.runtime
  source_archive_bucket    = var.bucket_name
  source_archive_object    = var.bucket_object_name
  entry_point             = var.automation_function_entry_point

  event_trigger {
    event_type = var.event_type
    resource   = var.bucket_id
  }
}
