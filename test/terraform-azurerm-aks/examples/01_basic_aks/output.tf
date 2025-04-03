output "aks_cluster_id" {
  description = "The AKS cluster ID created"
  value       = module.aks01.aks_cluster_id
}

output "aks_cluster_name" {
  description = "The AKS cluster ID name"
  value       = module.aks01.aks_cluster_name
}

output "aks_cluster_kubernetes_version" {
  description = "The AKS cluster version"
  value       = module.aks01.aks_cluster_kubernetes_version
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster."
  value       = module.aks01.oidc_issuer_url
}

output "admin_host" {
  description = "The `host` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. The Kubernetes cluster server host."
  sensitive   = true
  value       = module.aks01.admin_host
}

output "admin_password" {
  description = "The `password` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A password or token used to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = module.aks01.admin_password
}

output "admin_username" {
  description = "The `username` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A username used to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = module.aks01.admin_username
}
