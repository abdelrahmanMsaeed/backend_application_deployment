resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.private_subnet_name.region
  network = google_compute_network.vpc_network.id
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}