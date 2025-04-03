// ACR PULL
resource "azurerm_user_assigned_identity" "acr_pull" {
  for_each = toset(var.enable_managed_identity_creation ? ["enabled"] : [])

  location            = var.location
  name                = format("id-acrpull-%s", azurerm_container_registry.registry.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_acr_pull" {
  for_each = azurerm_user_assigned_identity.acr_pull

  scope                = azurerm_container_registry.registry.id
  role_definition_name = "AcrPull"
  principal_id         = each.value.principal_id

  depends_on = [azurerm_user_assigned_identity.acr_pull]
}

// ACR PUSH
resource "azurerm_user_assigned_identity" "acr_push" {
  for_each = toset(var.enable_managed_identity_creation ? ["enabled"] : [])

  location            = var.location
  name                = format("id-acrpush-%s", azurerm_container_registry.registry.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_acr_push" {
  for_each = azurerm_user_assigned_identity.acr_push

  scope                = azurerm_container_registry.registry.id
  role_definition_name = "AcrPush"
  principal_id         = each.value.principal_id

  depends_on = [azurerm_user_assigned_identity.acr_push]
}
