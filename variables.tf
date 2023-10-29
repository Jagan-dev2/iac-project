# Define a map of instance names and their machine types
variable "instances" {
  default = {
    "jenkins-master" = "e2-medium",
    "ansible"        = "e2-medium"
    "jenkins-slave"  = "e2-medium"
  }
}

variable "project_id" {
  default = ""
}


variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  default     = 1
}

variable "enabled_apis" {
  description = "List of APIs to enable"
  type        = map(string)
  default = {
    "cloudresourcemanager.googleapis.com" = "Cloud Resource Manager API"
    "compute.googleapis.com"              = "Compute Engine API"
    "storage-component.googleapis.com"    = "Storage API"
    # Add more APIs as needed
  }
}
