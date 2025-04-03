output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = module.vmwindows.vm_id
}

output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = module.vmwindows.vm_name
}

output "vm_hostname" {
  description = "Hostname of the Virtual Machine"
  value       = module.vmwindows.vm_hostname
}

output "vm_public_ip_id" {
  description = "Public IP ID of the Virtual Machine"
  value       = module.vmwindows.vm_public_ip_id
}

output "vm_private_ip_address" {
  description = "Private IP address of the Virtual Machine"
  value       = module.vmwindows.vm_private_ip_address
}

output "vm_nic_name" {
  description = "Name of the Network Interface Configuration attached to the Virtual Machine"
  value       = module.vmwindows.vm_nic_name
}

output "vm_nic_id" {
  description = "ID of the Network Interface Configuration attached to the Virtual Machine"
  value       = module.vmwindows.vm_nic_id
}

output "vm_nic_ip_configuration_name" {
  description = "Name of the IP Configuration for the Network Interface Configuration attached to the Virtual Machine"
  value       = module.vmwindows.vm_nic_ip_configuration_name
}

output "vm_identity" {
  description = "Identity block with principal ID"
  value       = module.vmwindows.vm_identity
}

output "vm_admin_username" {
  description = "Virtual Machine admin username"
  value       = module.vmwindows.vm_admin_username
  sensitive   = true
}

output "vm_admin_password" {
  description = "Virtual Machine admin password"
  value       = module.vmwindows.vm_admin_password
  sensitive   = true
}

output "vm_os_disk" {
  description = "Virtual Machine OS disk"
  value       = module.vmwindows.vm_os_disk
}

output "maintenance_configurations_assignments" {
  description = "Maintenance configurations assignments configurations."
  value       = module.vmwindows.maintenance_configurations_assignments
}

output "nic_id" {
  description = "NIC id associated with vm."
  value       = module.vmwindows.nic_id
}
