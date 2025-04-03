variable "log_analytics_workspace_enabled" {
  type        = bool
  description = "Enable the integration of azurerm_log_analytics_workspace and azurerm_log_analytics_solution: https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard"
  default     = true
  nullable    = false
}

variable "diag_log_analytics_workspace_id" {
  type        = string
  description = "(Optional) Existing azurerm_log_analytics_workspace to attach azurerm_log_analytics_solution. Providing the config disables creation of azurerm_log_analytics_workspace."
  default     = null
}
