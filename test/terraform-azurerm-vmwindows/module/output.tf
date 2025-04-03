output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.vmwindows.id
}

output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.vmwindows.name
}

output "vm_hostname" {
  description = "Hostname of the Virtual Machine"
  value       = azurerm_windows_virtual_machine.vmwindows.computer_name
}

output "vm_public_ip_id" {
  description = "Public IP ID of the Virtual Machine"
  value       = var.public_ip_address_id
}

output "vm_private_ip_address" {
  description = "Private IP address of the Virtual Machine"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "vm_nic_name" {
  description = "Name of the Network Interface Configuration attached to the Virtual Machine"
  value       = azurerm_network_interface.nic.name
}

output "vm_nic_id" {
  description = "ID of the Network Interface Configuration attached to the Virtual Machine"
  value       = azurerm_network_interface.nic.id
}

output "vm_nic_ip_configuration_name" {
  description = "Name of the IP Configuration for the Network Interface Configuration attached to the Virtual Machine"
  value       = local.ip_configuration_name
}

output "vm_identity" {
  description = "Identity block with principal ID"
  value       = azurerm_windows_virtual_machine.vmwindows.identity
}

output "vm_admin_username" {
  description = "Virtual Machine admin username"
  value       = azurerm_windows_virtual_machine.vmwindows.admin_username
  sensitive   = true
}

output "vm_admin_password" {
  description = "Virtual Machine admin password"
  value       = azurerm_windows_virtual_machine.vmwindows.admin_password
  sensitive   = true
}

output "vm_os_disk" {
  description = "Virtual Machine OS disk"
  value       = local.vm_os_disk_name
}

output "maintenance_configurations_assignments" {
  description = "Maintenance configurations assignments configurations."
  value       = azurerm_maintenance_assignment_virtual_machine.maintenace_configurations
}

output "nic_id" {
  description = "NIC id associated with vm."
  value       = azurerm_network_interface.nic.id
}
