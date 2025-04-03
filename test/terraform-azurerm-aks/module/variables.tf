variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "location" {
  type        = string
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  nullable    = false
}

variable "kubernetes_version" {
  type        = string
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "orchestrator_version" {
  description = "Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version"
  type        = string
  default     = null
}

variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "automatic_channel_upgrade" {
  type        = string
  default     = null
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`. By default automatic-upgrades are turned off. Note that you cannot use the `patch` upgrade channel and still specify the patch version using `kubernetes_version`. See [the documentation](https://learn.microsoft.com/en-us/azure/aks/auto-upgrade-cluster) for more information"
  validation {
    condition = var.automatic_channel_upgrade == null ? true : contains([
      "patch", "stable", "rapid", "node-image"
    ], var.automatic_channel_upgrade)
    error_message = "`automatic_channel_upgrade`'s possible values are `patch`, `stable`, `rapid` or `node-image`."
  }
}

variable "agents_count" {
  type        = number
  description = "The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes."
  default     = 1
}

variable "azure_policy_enabled" {
  type        = bool
  description = "(Optional) Enable Azure Policy Addon to manage and report on the compliance state of your Kubernetes clusters from one place. More information [can be found in the documentation](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes) "
  default     = true
}

variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created."
  default     = null
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Standard (which includes the Uptime SLA)"
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "Possible values are 'Free' or 'Standard'"
  }
}

variable "agents_max_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = null
}

variable "agents_size" {
  type        = string
  description = "The size of the Virtual Machine, such as Standard_DS2_**. Changing this forces a new resource to be created"
  validation {
    condition     = anytrue([var.agents_size == "Standard_D4s_v3", var.agents_size == "Standard_D8s_v3", var.agents_size == "Standard_D16s_v3", var.agents_size == "Standard_D2s_v3"])
    error_message = "Agent VM Size must be `Standard_D4s_v3`, `Standard_D8s_v3`, Standard_D16s_v3 or `Standard_D2s_v3`."
  }

  default = "Standard_D4s_v3"
}

variable "enable_auto_scaling" {
  type        = bool
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?. Requires that the type is set to VirtualMachineScaleSets"
  default     = false
}

variable "agents_type" {
  type        = string
  description = "(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets."
  default     = "VirtualMachineScaleSets"
}

variable "enable_host_encryption" {
  type        = bool
  description = "Enable Host Encryption for default node pool. Changing this forces a new resource to be created. Encryption at host feature must be enabled on the subscription: https://docs.microsoft.com/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli"
  default     = false
}

variable "agents_max_pods" {
  type        = number
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = null
}

variable "agents_min_count" {
  type        = number
  description = "(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = null
}

variable "agents_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  default     = {}
}

variable "only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created."
  default     = null
}

variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS Disk in GB which should be used for each agent in the Node Pool. Changing this forces a new resource to be created"
  default     = 50
}

variable "os_disk_type" {
  type        = string
  description = "The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. Changing this forces a new resource to be created."
  default     = "Managed"
  nullable    = false
}

variable "scale_down_mode" {
  type        = string
  description = "(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. If not specified, it defaults to `Delete`. Possible values include `Delete` and `Deallocate`. Changing this forces a new resource to be created."
  default     = "Delete"
}

variable "ultra_ssd_enabled" {
  type        = bool
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false. Changing this forces a new resource to be created"
  default     = false
}

variable "agents_availability_zones" {
  type        = list(string)
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  default     = null
}

variable "auto_scaler_profile_enabled" {
  type        = bool
  description = "Enable configuring the auto scaler profile"
  default     = false
  nullable    = false
}

variable "auto_scaler_profile_balance_similar_node_groups" {
  description = "Detect similar node groups and balance the number of nodes between them. Valid values are 'true' and 'false. Defaults to `false`."
  type        = bool
  default     = false
}

variable "auto_scaler_profile_empty_bulk_delete_max" {
  description = "Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`."
  type        = number
  default     = 10
}

variable "auto_scaler_profile_expander" {
  description = "Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`."
  validation {
    condition     = contains(["least-waste", "most-pods", "priority", "random"], var.auto_scaler_profile_expander)
    error_message = "Must be either `least-waste`, `most-pods`, `priority` or `random`."
  }
  type    = string
  default = "random"
}

variable "auto_scaler_profile_max_graceful_termination_sec" {
  description = "Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`."
  type        = string
  default     = "600"
}

variable "auto_scaler_profile_max_node_provisioning_time" {
  description = "Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`."
  type        = string
  default     = "15m"
}

variable "auto_scaler_profile_max_unready_nodes" {
  description = "Maximum Number of allowed unready nodes. Defaults to `3`."
  type        = number
  default     = 3
}

variable "auto_scaler_profile_max_unready_percentage" {
  description = "Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`."
  type        = number
  default     = 45
}

variable "auto_scaler_profile_new_pod_scale_up_delay" {
  description = "For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to `10s`."
  type        = string
  default     = "10s"
}

variable "auto_scaler_profile_scale_down_delay_after_add" {
  description = "How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`."
  type        = string
  default     = "10m"
}

variable "auto_scaler_profile_scale_down_delay_after_failure" {
  description = "How long after scale down failure that scale down evaluation resumes. Defaults to `3m`."
  type        = string
  default     = "3m"
}

variable "auto_scaler_profile_scale_down_unneeded" {
  description = "How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`."
  type        = string
  default     = "10m"
}

variable "auto_scaler_profile_scale_down_unready" {
  description = "How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`."
  type        = string
  default     = "20m"
}

variable "auto_scaler_profile_scale_down_utilization_threshold" {
  description = "Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`."
  type        = string
  default     = "0.5"
}

variable "auto_scaler_profile_scan_interval" {
  description = "How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`."
  type        = string
  default     = "10s"
}

variable "auto_scaler_profile_skip_nodes_with_local_storage" {
  description = "If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`."
  type        = bool
  default     = true
}

variable "auto_scaler_profile_skip_nodes_with_system_pods" {
  description = "If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`."
  type        = bool
  default     = true
}

variable "auto_scaler_profile_scale_down_delay_after_delete" {
  description = "How long after node deletion that scale down evaluation resumes. Defaults to the value used for `scan_interval`."
  type        = string
  default     = null
}

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = set(number)
    })),
    not_allowed = list(object({
      end   = string
      start = string
    })),
  })
  description = "(Optional) Maintenance configuration of the managed cluster."
  default     = null
}
