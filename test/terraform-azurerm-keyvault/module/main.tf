resource "azurerm_key_vault" "kv" {
  #checkov:skip=CKV_AZURE_110:Purge protection enabled by default
  #checkov:skip=CKV_AZURE_42:Keys are recoverable by default

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name  = var.sku
  tenant_id = var.tenant_id

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enabled_rbac_authorization

  purge_protection_enabled      = var.purge_protection_enabled
  public_network_access_enabled = var.public_network_access_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [true] : []
    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }


  dynamic "access_policy" {
    for_each = var.use_kv_access_policy ? local.combined_access_policies : []
    content {
      tenant_id               = var.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }

  tags = merge(var.default_tags, var.extra_tags)
}
