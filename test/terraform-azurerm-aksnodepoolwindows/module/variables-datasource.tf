variable "kubernetes_cluster" {
  type        = string
  description = "The details of existing Kubernetes Managed Cluster"
  nullable    = false
}

variable "kubernetes_cluster_resource_group_name" {
  type        = string
  description = "The Resource Group of the Managed Kubernetes Cluster. Changing this forces a new resource to be created."
  nullable    = false
}
