output "aks_cluster_id" {
  description = "The AKS cluster ID created"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_cluster_name" {
  description = "The AKS cluster ID name"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_kubernetes_version" {
  description = "The AKS cluster version"
  value       = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster."
  value       = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
}

output "admin_host" {
  description = "The `host` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. The Kubernetes cluster server host."
  sensitive   = true
  value       = try(azurerm_kubernetes_cluster.aks_cluster.kube_admin_config[0].host, "")
}

output "admin_password" {
  description = "The `password` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A password or token used to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = try(azurerm_kubernetes_cluster.aks_cluster.kube_admin_config[0].password, "")
}

output "admin_username" {
  description = "The `username` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A username used to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = try(azurerm_kubernetes_cluster.aks_cluster.kube_admin_config[0].username, "")
}
