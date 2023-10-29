
resource "google_project_service" "enable_apis" {
  for_each = var.enabled_apis

  project = var.project_id # Replace with your GCP project ID
  service = each.key
}

# Create VM instances
resource "google_compute_instance" "instances" {
  for_each = var.instances

  name         = each.key
  machine_type = each.value
  zone         = "us-central1-a" # You can choose a different zone if needed

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230907"
      //image = "ubuntu-os-cloud/ubuntu-2004-lts"  # Ubuntu 20.04 image
    }
  }

  network_interface {
    network = "default" # You can specify a different network if needed
    access_config {
      network_tier = "PREMIUM"
    }
  }
  connection {
    type = "ssh"
    user = "siva"
    # host        = self.network_interface[0].access_config[0].nat_ip
    host        = self.network_interface[0].access_config[0].nat_ip
    private_key = file("ssh-key")
  }
  provisioner "file" {
    source      = each.key == "ansible" ? "ansible.sh" : "empty.sh"
    destination = each.key == "ansible" ? "/home/siva/ansible.sh" : "/home/siva/empty.sh"
  }
  provisioner "remote-exec" {
    inline = [
      each.key == "ansible" ? "chmod +x /home/siva/ansible.sh && sh /home/siva/ansible.sh" : "echo 'Skipped Command'"
    ]
  }
  provisioner "file" {
    source      = "ssh-key"
    destination = "/home/siva/ssh-key"
  }
  tags = [each.key]
}

# Output a map of external IP addresses for all instances

resource "google_service_account" "jenkins-gke-svc-account" {
  account_id   = "jenkins-gke-svc-account"
  display_name = "Jenkins GKE Service Account"
}

/*
resource "google_project_iam_binding" "jenkins-gke-svc-account_binding" {
  project = var.project_id # Replace with your GCP project ID
  role    = "roles/owner"  # Change the role to 'roles/owner'
  #members = [google_service_account.jenkins-gke-svc-account.email]
  members = ["serviceAccount:${google_service_account.jenkins-gke-svc-account.email}"]

}*/


