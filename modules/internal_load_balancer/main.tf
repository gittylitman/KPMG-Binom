resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = var.neg_name[count.index]
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = var.cloud_run_names[count.index]
  }

  count = length(var.neg_name)
}

resource "google_compute_region_backend_service" "backend_service" {
  name                  = var.backend_service_name[count.index]
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  protocol              = "HTTPS"
  backend {
    group = google_compute_region_network_endpoint_group.serverless_neg[count.index].id
  }

  count = length(var.backend_service_name)
}

resource "google_compute_region_url_map" "url_map" {
  name   = var.lb_name
  region = var.region

  default_service = google_compute_region_backend_service.backend_service[0].id

  host_rule {
    hosts        = ["*"]
    path_matcher = "path-matcher"
  }

  path_matcher {
    name = "path-matcher"

    default_service = google_compute_region_backend_service.backend_service[0].id

    path_rule {
      paths   = ["/GetResult"]
      service = google_compute_region_backend_service.backend_service[0].id
    }

    path_rule {
      paths   = ["/GetSummary"]
      service = google_compute_region_backend_service.backend_service[1].id
    }
  }
}

data "google_compute_region_ssl_certificate" "ca_cert" {
  name        = var.cert_name
}

resource "google_compute_subnetwork" "proxy_subnet" {
  name          = var.subnet_proxy_name
  region        = var.region
  ip_cidr_range = var.ip_range
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = var.network_id
  project = var.host_project_id
}

resource "google_compute_region_target_https_proxy" "https_proxy" {
  name            = var.https_proxy_name
  region          = var.region
  url_map         = google_compute_region_url_map.url_map.id
  ssl_certificates = [data.google_compute_region_ssl_certificate.ca_cert.id]
}

resource "google_compute_forwarding_rule" "https_forwarding_rule" {
  name                  = var.https_forwarding_rule_name
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  target                = google_compute_region_target_https_proxy.https_proxy.self_link
  port_range            = "443"
  network               = var.network
  subnetwork            = var.subnetwork
  depends_on = [ google_compute_subnetwork.proxy_subnet ]
}
