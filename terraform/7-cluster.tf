resource "google_container_cluster" "project-cluster" {
  name       = "project-cluster"
  location   = var.region
  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.private_subnet.id
  depends_on = [google_compute_subnetwork.private_subnet]
 # creating the least possible node pool
  remove_default_node_pool = true
  initial_node_count       = 1
  
     master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.0.0/16"
    }
  }
  
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.16.0.0/16"
    services_ipv4_cidr_block = "10.12.0.0/16"
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    master_global_access_config {
      enabled = false
    }
  }
}
resource "google_container_node_pool" "project-nodes" {
  name       = "final-node-pool"
  location   = var.region
  cluster    = google_container_cluster.project-cluster.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    service_account = google_service_account.sa_gke
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}