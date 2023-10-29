resource "google_container_cluster" "my_cluster" {
  name               = "cart-cluster"
  location           = "us-central1-a" # Zonal Cluster
  initial_node_count = var.node_count # Worker Nodes
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50
    # Add any additional node configuration options here as needed
  }
}
