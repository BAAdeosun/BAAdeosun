output "nodepool_name" {
  description = "Name of the AKS Node Pool created"
  value       = { for n, r in azurerm_kubernetes_cluster_node_pool.node_pool : n => r.name }
}

output "host_group_id" {
  description = "Node Pool group ID"
  value       = { for n, r in azurerm_kubernetes_cluster_node_pool.node_pool : n => r.id }
}

output "os_type" {
  description = "Node Pool OS flavour"
  value       = { for n, r in azurerm_kubernetes_cluster_node_pool.node_pool : n => r.os_type }
}
