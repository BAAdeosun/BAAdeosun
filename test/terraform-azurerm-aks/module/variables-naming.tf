variable "landing_zone_slug" {
  description = "Landing zone acronym,this will be used to generate the resource name"
  type        = string
}

variable "custom_name" {
  description = "Custom AKS Name, it will overide the generate name if set"
  type        = string
  default     = ""
}

variable "workload_info" {
  description = "Workload additional info to be used in the resource name"
  type        = string
  default     = ""
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "agents_pool_name" {
  type        = string
  description = "The default Azure AKS agentpool (nodepool) name."
  default     = "nodepool"
  nullable    = false
}

variable "ingress_application_gateway_name" {
  type        = string
  description = "The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}
