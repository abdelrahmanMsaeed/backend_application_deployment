terraform {
  backend "gcs" {
    bucket  = "backend_application_deployment_storage"
    prefix  = "terraform/state"
  }
}