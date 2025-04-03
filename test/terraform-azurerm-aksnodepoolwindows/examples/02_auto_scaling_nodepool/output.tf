output "nodepool_name" {
  description = "Name of the AKS Node Pool created"
  value       = module.nodepool_windows02.nodepool_name
}

output "host_group_id" {
  description = "Node Pool group ID"
  value       = module.nodepool_windows02.host_group_id
}

output "os_type" {
  description = "Node Pool OS flavour"
  value       = module.nodepool_windows02.os_type
}
