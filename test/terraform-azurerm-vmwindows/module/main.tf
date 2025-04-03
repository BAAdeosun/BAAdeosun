resource "azurerm_windows_virtual_machine" "vmwindows" {
  #checkov:skip=CKV_AZURE_12:Ensure that Network Security Group Flow Log retention period is 'greater than 90 days'
  #checkov:skip=CKV_AZURE_50:Ensure Virtual Machine Extensions are not Installed
  #checkov:skip=CKV_AZURE_151:Ensure Windows VM enables encryption
  name                         = local.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  size                         = var.virtual_machine_size
  computer_name                = local.vm_hostname
  license_type                 = var.license_type
  secure_boot_enabled          = var.secure_boot_enabled
  vtpm_enabled                 = var.vtpm_enabled
  timezone                     = var.timezone
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  admin_username               = var.adminuser
  admin_password               = local.admin_password
  network_interface_ids        = [azurerm_network_interface.nic.id]
  zone                         = var.zone_id
  availability_set_id          = var.availability_set_id

  os_disk {
    name                      = local.vm_os_disk_name
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_storage_account_type
    disk_size_gb              = var.os_disk_size_gb
    disk_encryption_set_id    = var.disk_encryption_set_id
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
  }

  source_image_id = var.source_image_id

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["version"]
    }
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  dynamic "boot_diagnostics" {
    for_each = var.diagnostics_storage_account_name != null ? [1] : []
    content {
      storage_account_uri = "https://${var.diagnostics_storage_account_name}.blob.core.windows.net"
    }
  }

  dynamic "winrm_listener" {
    for_each = var.listener_protocol != null ? [1] : []
    content {
      protocol        = var.listener_protocol
      certificate_url = var.listener_protocol == "Https" ? var.certificate_secret_url : null
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content != null ? [1] : []
    content {
      content = var.additional_unattend_content
      setting = var.additional_unattend_content_setting
    }
  }

  custom_data = var.custom_data
  user_data   = var.user_data

  allow_extension_operations   = var.allow_extension_operations
  provision_vm_agent           = var.provision_vm_agent
  enable_automatic_updates     = var.enable_automatic_updates
  hotpatching_enabled          = var.hotpatching_enabled
  patch_mode                   = var.patch_mode
  patch_assessment_mode        = var.patch_mode == "AutomaticByPlatform" ? var.patch_mode : "ImageDefault"
  encryption_at_host_enabled   = var.enable_encryption_at_host
  proximity_placement_group_id = var.proximity_placement_group_id
  priority                     = var.spot_instance ? "Spot" : "Regular"
  max_bid_price                = var.spot_instance ? var.spot_instance_max_bid_price : null
  eviction_policy              = var.spot_instance ? var.spot_instance_eviction_policy : null

  tags = merge(var.default_tags, var.extra_tags, local.dfc_tags)
}

resource "random_password" "passwd" {
  length      = var.random_password_length
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  special     = true

  keepers = {
    admin_password = local.name
  }
}

resource "azurerm_managed_disk" "data_disk" {
  #checkov:skip=CKV_AZURE_93:Ensure that managed disks use a specific set of disk encryption sets for the customer-managed key
  for_each               = local.data_disks
  name                   = "disk-${each.value.idx}-${local.name}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  storage_account_type   = lookup(each.value.data_disk, "storage_account_type", "StandardSSD_LRS")
  create_option          = "Empty"
  disk_size_gb           = each.value.data_disk.disk_size_gb
  disk_encryption_set_id = var.disk_encryption_set_id
  tags                   = merge({ "ResourceName" = "disk-${each.value.idx}-${local.name}" }, var.disk_extra_tags, )
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each           = local.data_disks
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vmwindows.id
  lun                = each.value.idx
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_extension" "extension" {
  for_each                    = { for k, v in var.vm_extension == null ? [] : var.vm_extension : k => v }
  virtual_machine_id          = azurerm_windows_virtual_machine.vmwindows.id
  name                        = "${local.name}-${each.value.name}"
  publisher                   = each.value.publisher
  type                        = each.value.type
  type_handler_version        = each.value.type_handler_version
  auto_upgrade_minor_version  = each.value.auto_upgrade_minor_version
  automatic_upgrade_enabled   = each.value.automatic_upgrade_enabled
  failure_suppression_enabled = each.value.failure_suppression_enabled
  settings                    = each.value.settings
  protected_settings          = each.value.protected_settings

  dynamic "protected_settings_from_key_vault" {
    for_each = each.value.protected_settings_from_key_vault == null ? [] : [1]
    content {
      secret_url      = each.value.protected_settings_from_key_vault.secret_url
      source_vault_id = each.value.protected_settings_from_key_vault.source_vault_id
    }
  }

  tags = merge(var.default_tags, var.extra_tags)
}

resource "azurerm_maintenance_assignment_virtual_machine" "maintenace_configurations" {
  for_each                     = toset(var.maintenance_configuration_ids)
  location                     = var.location
  maintenance_configuration_id = each.value
  virtual_machine_id           = azurerm_windows_virtual_machine.vmwindows.id
}

resource "azurerm_backup_protected_vm" "backup" {
  for_each = toset(var.backup_policy_id != null ? ["enabled"] : [])

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.backup_recovery_vault_name
  source_vm_id        = azurerm_windows_virtual_machine.vmwindows.id
  backup_policy_id    = var.backup_policy_id
}
