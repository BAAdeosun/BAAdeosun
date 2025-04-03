output "kv_vault_uri" {
  description = "The Key Vault URI."
  value       = module.keyvault.kv_vault_uri
}

output "kv_id" {
  description = "The Key Vault id."
  value       = module.keyvault.kv_id
}

output "kv_name" {
  description = "The Key Vault name."
  value       = module.keyvault.kv_name
}

output "kv_secrets_user" {
  description = "Created identity with role `Key Vault Secrets User`."
  value       = module.keyvault.kv_secrets_user
}

output "kv_crypto_user" {
  description = "Created identity with role `Key Vault Crypto User`."
  value       = module.keyvault.kv_crypto_user
}

output "kv_admin" {
  description = "Created identity with role `Key Vault Administrator`."
  value       = module.keyvault.kv_admin
}
