resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "vm_instance_service_account" {
  account_id   = var.service_account_vm_name
  display_name = "SA for windows-VM Instance"
  depends_on = [ google_project_service.iam ]
}

resource "google_compute_instance" "windows_vm"{
    name = var.vm_name
    machine_type = var.machine_type
    zone = var.zone
    boot_disk {
      initialize_params {
        image = var.image
      }
    }
    network_interface {
      network = var.network_id
      subnetwork = var.subnetwork_id
    }
    service_account {
      email = google_service_account.vm_instance_service_account.email
      scopes = ["cloud-platform"]
    }
}
