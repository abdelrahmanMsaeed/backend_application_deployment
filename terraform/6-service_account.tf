resource "google_service_account" "vm_service_account" {
  account_id   = "service-acount-for-private-vm"
  display_name = "service-acount-for-private-vm"
}


resource "google_project_iam_binding" "role_binding" {
  project = "active-sun-337308"
  role    = "roles/container.admin"
  depends_on = [
    google_service_account.vm_service_account
  ]
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}"
  ]
}

resource "google_project_iam_binding" "role_binding1" {
  project = "active-sun-337308"
  role    = "roles/container.clusterAdmin"
  depends_on = [
    google_service_account.vm_service_account
  ]
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}"
  ]
}
resource "google_project_iam_binding" "role_binding2" {
  project = "active-sun-337308"
  role    = "roles/container.developer"
  depends_on = [
    google_service_account.vm_service_account
  ]
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}"
  ]
}



###### Service Account for GKE ######

resource "google_service_account" "sa_gke" {
  account_id   = "service-acount-for-gke-project"
  display_name = "service-acount-for-gke-project"
}

resource "google_project_iam_binding" "sa_gke2" {
  project = "active-sun-337308"
  role    = "roles/container.admin"
  depends_on = [
    google_service_account.sa_gke
  ]
  members = [
    "serviceAccount:${google_service_account.sa_gke.email}"
  ]
}
resource "google_project_iam_binding" "sa_gke1" {
  project = "active-sun-337308"
  role    = "roles/storage.admin"
  depends_on = [
    google_service_account.sa_gke
  ]
  members = [
    "serviceAccount:${google_service_account.sa_gke.email}"
  ]
}
