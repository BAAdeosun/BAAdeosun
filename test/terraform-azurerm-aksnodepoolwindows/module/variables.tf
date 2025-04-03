variable "agents_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  default     = {}
}

variable "add_node_pools" {
  type = map(object({
    nodepool_name                   = string
    nodepool_node_count             = number
    nodepool_vm_size                = optional(string)
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
    fips_enabled      = optional(bool)
    kubelet_disk_type = optional(string, "OS")
    nodepool_mode     = optional(string, "User")
    node_max_count    = optional(number)
    node_min_count    = optional(number)
    agent_max_pods    = optional(number)
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
    nodepool_os_type                  = optional(string, "Windows")
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
    windows_profile = optional(object({
      outbound_nat_enabled = optional(bool, true)
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
      length(v.nodepool_name) <= 6
    ])
    error_message = "Windows node pool name must not exceed 6 characters."
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
      ["Windows2022", "Windows2019", "Standard_D16s_v3", "Standard_D2s_v3"], nodepool_os_sku)
    ]) <= 0
    error_message = "Only 'Windows2022' and  'Windows2019', are allowed values for Windows nodepool_os_sku."
  }

  default = {}
}
