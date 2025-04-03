resource "azurerm_private_endpoint" "keyvault_pep" {
  count = var.enable_private_endpoint == true ? 1 : 0

  name                = format("pe-%s", local.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = merge(var.default_tags, var.extra_tags)
  private_dns_zone_group {
    name                 = format("%s-group", "keyvault")
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  private_service_connection {
    name                           = format("%s-privatelink", "keyvault")
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
  }
}
