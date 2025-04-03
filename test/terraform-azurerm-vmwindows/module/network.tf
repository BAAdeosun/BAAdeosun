resource "azurerm_network_interface" "nic" {
  name                          = "nic-${local.name}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_servers                   = var.dns_servers
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  internal_dns_name_label       = var.internal_dns_name_label

  ip_configuration {
    name                          = local.ip_configuration_name
    primary                       = true
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.static_private_ip == null ? "Dynamic" : "Static"
    private_ip_address            = var.static_private_ip
    public_ip_address_id          = var.public_ip_address_id != null ? var.public_ip_address_id[0] : null
  }

  tags = merge(var.default_tags, var.extra_tags, var.nic_extra_tags)
}

resource "azurerm_network_interface_security_group_association" "nsga" {
  #checkov:skip=CKV_AZURE_12:Ensure that Network Security Group Flow Log retention period is 'greater than 90 days'
  count                     = (var.public_ip_address_id != null || var.network_security_group_id != null) ? 1 : 0
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = local.nsg_id
}

resource "azurerm_network_security_group" "nsg" {
  count               = var.public_ip_address_id != null ? 1 : 0
  name                = "nsg-${local.name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                                       = lookup(security_rule.value, "name", null)
      priority                                   = lookup(security_rule.value, "priority", null)
      direction                                  = lookup(security_rule.value, "direction", null)
      access                                     = lookup(security_rule.value, "access", null)
      protocol                                   = lookup(security_rule.value, "protocol", null)
      source_port_range                          = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges                         = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_range                     = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges                    = lookup(security_rule.value, "destination_port_ranges", null)
      source_address_prefix                      = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes                    = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefix                 = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes               = lookup(security_rule.value, "destination_address_prefixes", null)
      source_application_security_group_ids      = lookup(security_rule.value, "source_application_security_group_ids", null)
      destination_application_security_group_ids = lookup(security_rule.value, "destination_application_security_group_ids", null)
    }
  }

  tags = merge(var.default_tags, var.extra_tags)
}
