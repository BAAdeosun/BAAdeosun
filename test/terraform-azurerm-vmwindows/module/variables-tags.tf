variable "default_tags" {
  description = "Default Base tagging"
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}

variable "disk_extra_tags" {
  description = "Disk tags"
  type        = map(string)
  default     = {}
}

variable "nic_extra_tags" {
  description = "Extra tags to set on the network interface."
  type        = map(string)
  default     = {}
}
