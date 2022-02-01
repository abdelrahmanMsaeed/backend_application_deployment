resource "google_compute_network" "vpc_network" {
  name = var.network_name
  auto_create_subnetworks = false
}


# public subnet
resource "google_compute_subnetwork" "public_subnet" {
    name = var.public_subnet_name
    ip_cidr_range = var.public_cidr
    region = var.region
    network = var.network_name
    depends_on = [google_compute_network.vpc_network]
}


# private subnet
resource "google_compute_subnetwork" "private_subnet" {
    name = var.private_subnet_name
    ip_cidr_range = var.private_cidr
    region = var.region
    network = var.network_name
    depends_on = [google_compute_network.vpc_network]
}


# firewall
resource "google_compute_firewall" "rules" {
  project     = var.project_id
  name        = "allowtcprules"
  network     = var.network_name
  depends_on = [google_compute_network.vpc_network]

  allow {
    protocol  = "tcp"
    ports     = ["80", "22", "443"]
  }
  
  source_ranges = ["35.235.240.0/20"]
}