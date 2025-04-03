locals {
  data_disks = { for idx, data_disk in var.data_disks : data_disk.name => {
    idx : idx,
    data_disk : data_disk,
    }
  }

  admin_password = var.admin_password == null ? element(concat(random_password.passwd.*.result, [""]), 0) : var.admin_password

  nsg_id = var.network_security_group_id != null ? var.network_security_group_id[0] : (var.public_ip_address_id != null ? azurerm_network_security_group.nsg[0].id : null)
}
