resource "google_project_service" "pubsub" {
  service            = "pubsub.googleapis.com"
  disable_on_destroy = false
}

data "google_project" "project" {}

data "google_storage_project_service_account" "gcs_account" {}

resource "google_service_account" "eventarc_sa" {
  account_id = var.sa_eventarc_name
  display_name = "Eventarc Trigger Service Account"
}

resource "google_project_iam_member" "eventreceiver" {
  project = data.google_project.project.id
  role = "roles/eventarc.eventReceiver"
  member = "serviceAccount:${google_service_account.eventarc_sa.email}"
}

resource "google_project_iam_member" "runinvoker" {
  project = data.google_project.project.id
  role = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.eventarc_sa.email}"
}

resource "google_project_iam_member" "tokencreator" {
  project = data.google_project.project.id
  role = "roles/iam.serviceAccountTokenCreator"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "pubsubpublisher" {
  project = data.google_project.project.id
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

module "cloud_run" {
  source = "../trigger_cloud_run"
  cloud_run_name = var.cloud_run_name
  location = var.location
  container_image = var.container_image
  service_account = google_service_account.eventarc_sa.email
  connector_name = var.connector_name
  host_project_id = var.host_project_id
}

module "eventarc" {
  source = "../eventarc"
  trigger_name = var.trigger_name
  cloud_run_location = module.cloud_run.location
  storage_bucket_name = var.cloud_storage_name
  cloud_run_name = module.cloud_run.name
  service_account = google_service_account.eventarc_sa.email
  depends_on = [ google_project_iam_member.pubsubpublisher ]
}
