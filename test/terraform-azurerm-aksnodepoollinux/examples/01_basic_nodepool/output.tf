output "nodepool_name" {
  description = "Name of the AKS Node Pool created"
  value       = module.nodepool_linux01.nodepool_name
}

output "host_group_id" {
  description = "Node Pool group ID"
  value       = module.nodepool_linux01.nodepool_name
}

output "os_type" {
  description = "Node Pool OS flavour"
  value       = module.nodepool_linux01.os_type
}
