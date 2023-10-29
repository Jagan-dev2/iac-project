# Specify the provider and authentication
provider "google" {
  credentials = file("credentials.json")
  project     = var.project_id
  region      = "us-central1"
}
