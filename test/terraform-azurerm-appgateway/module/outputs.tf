output "id" {
  description = "Id of the application gateway."
  value       = azurerm_application_gateway.app_gateway.id
}

output "name" {
  description = "Name of the application gateway."
  value       = azurerm_application_gateway.app_gateway.name
}

output "public_ip_id" {
  description = "The ID of appgw Public IP."
  value       = length(azurerm_public_ip.gateway) > 0 ? azurerm_public_ip.gateway[0].id : null
}

output "public_ip_address" {
  description = "The IP address value that was allocated."
  value       = length(azurerm_public_ip.gateway) > 0 ? azurerm_public_ip.gateway[0].ip_address : null
}

output "public_ip_fqdn" {
  description = "The Public IP FQDN"
  value       = length(azurerm_public_ip.gateway) > 0 ? azurerm_public_ip.gateway[0].fqdn : null
}
