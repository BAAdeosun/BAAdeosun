variable "allowed_subnets" {
  description = "List of VNet/Subnet IDs to allow on the registry."
  default     = []
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "List of CIDRs to allow on the registry"
  default     = []
  type        = list(string)
}

variable "public_network_access_enabled" {
  description = "Whether the Container Registry is accessible publicly."
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU)."
  default     = false
  type        = bool
}
variable "enable_private_endpoint" {
  description = "Wether the container registry is using a priavte endpoint"
  type        = bool
  default     = true
}

variable "private_dns_zone_id" {
  description = "Id of the private DNS Zone  to be used by the container registry private endpoint"
  type        = string
  default     = null
}

variable "private_endpoint_subnet_id" {
  description = "Id for the subnet used by the container registry private endpoint"
  type        = string
  default     = null
}
