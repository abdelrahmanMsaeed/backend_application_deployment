resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region
  network = google_compute_network.vpc_network.id
  bgp {
    asn            = 64514
  }
}

resource "google_compute_router" "router1" {
  name    = "ll"
  region  = var.region
  network = google_compute_network.vpc_network.id
  bgp {
    asn            = 64514
  }
}