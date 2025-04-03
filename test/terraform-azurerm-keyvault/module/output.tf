output "kv_vault_uri" {
  description = "The Key Vault URI."
  value       = azurerm_key_vault.kv.vault_uri
}

output "kv_id" {
  description = "The Key Vault id."
  value       = azurerm_key_vault.kv.id
}

output "kv_name" {
  description = "The Key Vault name."
  value       = azurerm_key_vault.kv.name
}

output "kv_secrets_user" {
  description = "Created identity with role `Key Vault Secrets User`."
  value       = lookup(azurerm_user_assigned_identity.kv_secrets_user, "enabled", null)
}

output "kv_crypto_user" {
  description = "Created identity with role `Key Vault Crypto User`."
  value       = lookup(azurerm_user_assigned_identity.kv_crypto_user, "enabled", null)
}

output "kv_admin" {
  description = "Created identity with role `Key Vault Administrator`."
  value       = lookup(azurerm_user_assigned_identity.kv_admin, "enabled", null)
}
