output "public_ips" {
  description = "Public IP addresses of the instances"
  value = {
    for instance in google_compute_instance.instances :
    instance.name => instance.network_interface[0].access_config[0].nat_ip
  }
}

output "private_ips" {
  description = "Private IP addresses of the instances"
  value = {
    for instance in google_compute_instance.instances :
    instance.name => instance.network_interface[0].network_ip
  }
}




output "svc_email" {
  value = google_service_account.jenkins-gke-svc-account.email
}
