resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }

  for_each = var.add_node_pools

  kubernetes_cluster_id         = data.azurerm_kubernetes_cluster.main.id
  name                          = local.name
  vm_size                       = each.value.nodepool_vm_size
  capacity_reservation_group_id = each.value.capacity_reservation_group_id
  custom_ca_trust_enabled       = each.value.custom_ca_trust_enabled
  enable_auto_scaling           = each.value.enable_auto_scaling
  enable_host_encryption        = each.value.enable_nodepool_host_encryption
  enable_node_public_ip         = each.value.enable_node_public_ip
  eviction_policy               = each.value.spot_eviction_policy
  fips_enabled                  = each.value.fips_enabled
  host_group_id                 = each.value.host_group_id
  kubelet_disk_type             = each.value.kubelet_disk_type
  max_count                     = each.value.node_max_count
  max_pods                      = each.value.agent_max_pods
  min_count                     = each.value.node_min_count
  mode                          = each.value.nodepool_mode
  node_count                    = each.value.nodepool_node_count
  node_labels                   = each.value.spot_node_labels
  node_public_ip_prefix_id      = each.value.node_public_ip_prefix_id
  node_taints                   = each.value.spot_node_taints
  orchestrator_version          = each.value.aks_agent_orchestrator_version
  os_disk_size_gb               = each.value.nodepool_os_disk_size_gb
  os_disk_type                  = each.value.nodepool_os_disk_type
  os_sku                        = each.value.nodepool_os_sku
  os_type                       = each.value.nodepool_os_type
  pod_subnet_id                 = each.value.pod_subnet_id
  priority                      = each.value.vmss_priority
  proximity_placement_group_id  = each.value.vmss_proximity_placement_group_id
  scale_down_mode               = each.value.nodepool_scale_down_mode
  spot_max_price                = each.value.spot_max_price
  ultra_ssd_enabled             = each.value.ultra_ssd_enabled
  vnet_subnet_id                = each.value.vnet_subnet_id
  workload_runtime              = each.value.workload_runtime
  zones                         = each.value.availability_zones
  tags                          = merge(var.default_tags, var.extra_tags)

  dynamic "kubelet_config" {
    for_each = each.value.kubelet_config == null ? [] : ["kubelet_config"]

    content {
      allowed_unsafe_sysctls    = each.value.kubelet_config.allowed_unsafe_sysctls_command
      container_log_max_line    = each.value.kubelet_config.container_log_max_files
      container_log_max_size_mb = each.value.kubelet_config.container_log_max_size_mb
      cpu_cfs_quota_enabled     = each.value.kubelet_config.containers_cpu_cfs_quota_enabled
      cpu_cfs_quota_period      = each.value.kubelet_config.containers_cpu_cfs_quota_period
      cpu_manager_policy        = each.value.kubelet_config.containers_cpu_manager_policy
      image_gc_high_threshold   = each.value.kubelet_config.image_disk_gc_high_threshold
      image_gc_low_threshold    = each.value.kubelet_config.image_disk_gc_low_threshold
      pod_max_pid               = each.value.kubelet_config.pod_max_pid
      topology_manager_policy   = each.value.kubelet_config.topology_manager_policy
    }
  }
  dynamic "node_network_profile" {
    for_each = each.value.node_network_profile == null ? [] : ["node_network_profile"]

    content {
      node_public_ip_tags = each.value.node_network_profile.node_public_ip_tags
    }
  }
  dynamic "upgrade_settings" {
    for_each = each.value.upgrade_settings == null ? [] : ["upgrade_settings"]

    content {
      max_surge = each.value.upgrade_settings.max_surge
    }
  }
  dynamic "windows_profile" {
    for_each = each.value.windows_profile == null ? [] : ["windows_profile"]

    content {
      outbound_nat_enabled = each.value.windows_profile.outbound_nat_enabled
    }
  }
}
