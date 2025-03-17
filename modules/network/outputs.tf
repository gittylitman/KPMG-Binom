output "network_name" {
  value = data.google_compute_network.vpc_network.name
}

output "subnet_name" {
  value = google_compute_subnetwork.subnetwork.name
}

output "network_id" {
  value = data.google_compute_network.vpc_network.id
}