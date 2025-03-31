resource "google_project_service" "eventarc" {
  service            = "eventarc.googleapis.com"
  disable_on_destroy = false
}

resource "google_eventarc_trigger" "eventarc_trigger" {
  name = var.trigger_name
  location = var.cloud_run_location
  matching_criteria {
    attribute = "type"
    value = var.event_type
  }
  matching_criteria {
    attribute = "bucket"
    value = var.storage_bucket_name
  }

  destination {
    cloud_run_service {
      service = var.cloud_run_name
      region = var.cloud_run_location
    }
  }

  service_account = var.service_account

  depends_on = [ 
    google_project_service.eventarc,
  ]
}
