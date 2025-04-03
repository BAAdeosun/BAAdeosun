variable "add_node_pools" {
  type = map(object({
    nodepool_name                   = string
    nodepool_node_count             = number
    nodepool_vm_size                = string
    enable_auto_scaling             = optional(bool)
    host_group_id                   = optional(string)
    capacity_reservation_group_id   = optional(string)
    custom_ca_trust_enabled         = optional(bool)
    enable_nodepool_host_encryption = optional(bool)
    enable_node_public_ip           = optional(bool)
    spot_eviction_policy            = optional(string)
    kubelet_config = optional(object({
      containers_cpu_manager_policy    = optional(string)
      containers_cpu_cfs_quota_enabled = optional(bool)
      containers_cpu_cfs_quota_period  = optional(string)
      image_disk_gc_high_threshold     = optional(number)
      image_disk_gc_low_threshold      = optional(number)
      topology_manager_policy          = optional(string)
      allowed_unsafe_sysctls_command   = optional(set(string))
      container_log_max_size_mb        = optional(number)
      container_log_max_files          = optional(number)
      pod_max_pid                      = optional(number)
    }))
    linux_os_config = optional(object({
      sysctl_config = optional(object({
        fs_aio_max_nr                      = optional(number)
        fs_file_max                        = optional(number)
        fs_inotify_max_user_watches        = optional(number)
        fs_nr_open                         = optional(number)
        kernel_threads_max                 = optional(number)
        net_core_netdev_max_backlog        = optional(number)
        net_core_optmem_max                = optional(number)
        net_core_rmem_default              = optional(number)
        net_core_rmem_max                  = optional(number)
        net_core_somaxconn                 = optional(number)
        net_core_wmem_default              = optional(number)
        net_core_wmem_max                  = optional(number)
        net_ipv4_ip_local_port_range_min   = optional(number)
        net_ipv4_ip_local_port_range_max   = optional(number)
        net_ipv4_neigh_default_gc_thresh1  = optional(number)
        net_ipv4_neigh_default_gc_thresh2  = optional(number)
        net_ipv4_neigh_default_gc_thresh3  = optional(number)
        net_ipv4_tcp_fin_timeout           = optional(number)
        net_ipv4_tcp_keepalive_intvl       = optional(number)
        net_ipv4_tcp_keepalive_probes      = optional(number)
        net_ipv4_tcp_keepalive_time        = optional(number)
        net_ipv4_tcp_max_syn_backlog       = optional(number)
        net_ipv4_tcp_max_tw_buckets        = optional(number)
        net_ipv4_tcp_tw_reuse              = optional(bool)
        net_netfilter_nf_conntrack_buckets = optional(number)
        net_netfilter_nf_conntrack_max     = optional(number)
        vm_max_map_count                   = optional(number)
        vm_swappiness                      = optional(number)
        vm_vfs_cache_pressure              = optional(number)
      }))
      transparent_huge_page_enabled = optional(string)
      transparent_huge_page_defrag  = optional(string)
      swap_file_size_mb             = optional(number)
    }))
    fips_enabled             = optional(bool)
    kubelet_disk_type        = optional(string, "OS")
    nodepool_mode            = optional(string, "User")
    node_max_count           = optional(number)
    node_min_count           = optional(number)
    agent_max_pods           = optional(number)
    linux_message_of_the_day = optional(string)
    node_network_profile = optional(object({
      node_public_ip_tags = optional(map(string))
    }))
    spot_node_labels                  = optional(map(string))
    node_public_ip_prefix_id          = optional(string)
    spot_node_taints                  = optional(list(string))
    aks_agent_orchestrator_version    = optional(string)
    nodepool_os_disk_size_gb          = optional(number)
    nodepool_os_disk_type             = optional(string, "Managed")
    nodepool_os_sku                   = optional(string)
    nodepool_os_type                  = optional(string, "Linux")
    pod_subnet_id                     = optional(string)
    vmss_priority                     = optional(string, "Regular")
    vmss_proximity_placement_group_id = optional(string)
    spot_max_price                    = optional(number)
    nodepool_scale_down_mode          = optional(string, "Delete")
    ultra_ssd_enabled                 = optional(bool)
    vnet_subnet_id                    = optional(string)
    upgrade_settings = optional(object({
      max_surge = number
    }))
    workload_runtime   = optional(string)
    availability_zones = optional(set(string))
  }))


  validation {
    condition = alltrue([
      for v in var.add_node_pools :
      !(v.nodepool_os_disk_type == "Managed" && v.ultra_ssd_enabled == true)
    ])
    error_message = "Bad combination, Managed disks doesn't support ultra SSD disks"
  }

  validation {
    condition = alltrue([
      for v in var.add_node_pools :
      !(v.node_max_count == null && v.node_min_count == null && v.enable_auto_scaling == false)
    ])
    error_message = "Bad combination, `node_max_count` and `node_min_count` must be set to `null` when enable_auto_scaling is set to `false`"
  }

  validation {
    condition = alltrue([
      for v in var.add_node_pools :
      length(v.nodepool_name) <= 12
    ])
    error_message = "Linux node pool name must not exceed 12 characters."
  }

  validation {
    condition = length([
      for nodepool_vm_size in values(var.add_node_pools)[*].nodepool_vm_size :
      nodepool_vm_size if !contains(
      ["Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D2s_v3"], nodepool_vm_size)
    ]) <= 0
    error_message = "Only Standard_D4s_v3, Standard_D8s_v3, Standard_D16s_v3, Standard_D2s_v3 are allowed values for Node Pool Size."
  }

  validation {
    condition = length([
      for nodepool_os_sku in values(var.add_node_pools)[*].nodepool_os_sku :
      nodepool_os_sku if !contains(
      ["Ubuntu", "CBLMariner", "Mariner"], nodepool_os_sku)
    ]) <= 0
    error_message = "Only Ubuntu, CBLMariner, Mariner are allowed values for Node Pool SKU."
  }

  default = {}
}
