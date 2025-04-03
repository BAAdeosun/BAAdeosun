resource "azurerm_user_assigned_identity" "kv_secrets_user" {
  for_each            = toset(!var.use_kv_access_policy ? ["enabled"] : [])
  location            = var.location
  name                = format("id-kv-secrets-user-%s", azurerm_key_vault.kv.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_kv_secrets_user" {
  for_each             = azurerm_user_assigned_identity.kv_secrets_user
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value.principal_id
}

resource "azurerm_user_assigned_identity" "kv_crypto_user" {
  for_each            = toset(!var.use_kv_access_policy ? ["enabled"] : [])
  location            = var.location
  name                = format("id-kv-crypto-user-%s", azurerm_key_vault.kv.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_kv_crypto_user" {
  for_each             = azurerm_user_assigned_identity.kv_crypto_user
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = each.value.principal_id
}

resource "azurerm_user_assigned_identity" "kv_admin" {
  for_each            = toset(!var.use_kv_access_policy ? ["enabled"] : [])
  location            = var.location
  name                = format("id-kv-admin-%s", azurerm_key_vault.kv.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_kv_admin" {
  for_each             = azurerm_user_assigned_identity.kv_admin
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value.principal_id
}