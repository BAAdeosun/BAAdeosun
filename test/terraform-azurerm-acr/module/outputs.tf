output "acr_id" {
  description = "The Container Registry ID."
  value       = azurerm_container_registry.registry.id
}

output "acr_name" {
  description = "The Container Registry name."
  value       = azurerm_container_registry.registry.name
}

output "acr_login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = azurerm_container_registry.registry.login_server
}

output "id_acr_pull" {
  description = "Id to the user-managed identity with ACrPull Role"
  value = one([
    for uai in azurerm_user_assigned_identity.acr_pull : uai
  ])
}

output "id_acr_push" {
  description = "Id to the user-managed identity with ACrPush Role"
  value = one([
    for uai in azurerm_user_assigned_identity.acr_push : uai
  ])
}
output "acr_data" {
  value = {
    server   = azurerm_container_registry.registry.login_server
    username = azurerm_container_registry.registry.admin_username
    password = azurerm_container_registry.registry.admin_password
  }
  description = "Details of the Azure Container Registry (ACR) including the login server URL, admin username, and admin password."
  sensitive   = true
}
