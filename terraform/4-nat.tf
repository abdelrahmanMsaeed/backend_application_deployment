resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = var.router_name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  depends_on = [google_compute_subnetwork.public_subnet]

  subnetwork {
    name                    = var.public_subnet_name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_router_nat" "natww" {
  name                               = "nnna"
  router                             = "ll"
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  depends_on = [google_compute_subnetwork.public_subnet]

  subnetwork {
    name                    = var.private_subnet_name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}