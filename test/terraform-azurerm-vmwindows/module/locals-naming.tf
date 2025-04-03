locals {
  service_slug           = "vm"
  landing_zone_slug      = var.landing_zone_slug
  application_id         = var.stack
  workload_info          = var.workload_info
  location_short         = var.location_short
  separator              = "-"
  generated_random_value = random_string.random.result
  name_components_list   = compact([local.service_slug, local.landing_zone_slug, local.location_short, local.application_id, local.workload_info, local.generated_random_value])
  standard_name          = join(local.separator, local.name_components_list)
  name                   = coalesce(lower(var.custom_name), lower(local.standard_name))
  host_name              = "${local.application_id}-${local.generated_random_value}"
  ip_configuration_name  = coalesce(var.custom_ipconfig_name, "nic-ipconfig-${local.name}")
  vm_hostname            = coalesce(var.hostname, var.custom_name, local.host_name)
  vm_os_disk_name        = coalesce(var.os_disk_custom_name, "osdisk-${local.name}")
}
