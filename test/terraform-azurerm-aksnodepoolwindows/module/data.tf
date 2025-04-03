data "azurerm_kubernetes_cluster" "main" {
  name                = var.kubernetes_cluster
  resource_group_name = var.kubernetes_cluster_resource_group_name
}
