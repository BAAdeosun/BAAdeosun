<!-- BEGIN_TF_DOCS -->
# Terraform AKS Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/)

## Description

Azure Kubernetes Service.

## Deploys an Azure Kubernetes cluster with monitoring support through Azure Log Analytics

This Terraform module deploys a Kubernetes cluster on Azure using AKS (Azure Kubernetes Service) and adds support for monitoring with Log Analytics.

## Example

[01\_basic\_aks](./examples/01\_basic\_aks/README.md)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.51.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.51.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/4.0.4/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,this will be used to generate the resource name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The Admin Username for the Cluster. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_agents_availability_zones"></a> [agents\_availability\_zones](#input\_agents\_availability\_zones) | (Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created. | `list(string)` | `null` | no |
| <a name="input_agents_count"></a> [agents\_count](#input\_agents\_count) | The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes. | `number` | `1` | no |
| <a name="input_agents_labels"></a> [agents\_labels](#input\_agents\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created. | `map(string)` | `{}` | no |
| <a name="input_agents_max_count"></a> [agents\_max\_count](#input\_agents\_max\_count) | The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 | `number` | `null` | no |
| <a name="input_agents_max_pods"></a> [agents\_max\_pods](#input\_agents\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_agents_min_count"></a> [agents\_min\_count](#input\_agents\_min\_count) | (Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 | `number` | `null` | no |
| <a name="input_agents_pool_name"></a> [agents\_pool\_name](#input\_agents\_pool\_name) | The default Azure AKS agentpool (nodepool) name. | `string` | `"nodepool"` | no |
| <a name="input_agents_size"></a> [agents\_size](#input\_agents\_size) | The size of the Virtual Machine, such as Standard\_DS2\_**. Changing this forces a new resource to be created | `string` | `"Standard_D4s_v3"` | no |
| <a name="input_agents_type"></a> [agents\_type](#input\_agents\_type) | (Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets. | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | (Optional) The IP ranges to allow for incoming traffic to the server nodes. | `set(string)` | `null` | no |
| <a name="input_auto_scaler_profile_balance_similar_node_groups"></a> [auto\_scaler\_profile\_balance\_similar\_node\_groups](#input\_auto\_scaler\_profile\_balance\_similar\_node\_groups) | Detect similar node groups and balance the number of nodes between them. Valid values are 'true' and 'false. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_auto_scaler_profile_empty_bulk_delete_max"></a> [auto\_scaler\_profile\_empty\_bulk\_delete\_max](#input\_auto\_scaler\_profile\_empty\_bulk\_delete\_max) | Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`. | `number` | `10` | no |
| <a name="input_auto_scaler_profile_enabled"></a> [auto\_scaler\_profile\_enabled](#input\_auto\_scaler\_profile\_enabled) | Enable configuring the auto scaler profile | `bool` | `false` | no |
| <a name="input_auto_scaler_profile_expander"></a> [auto\_scaler\_profile\_expander](#input\_auto\_scaler\_profile\_expander) | Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`. | `string` | `"random"` | no |
| <a name="input_auto_scaler_profile_max_graceful_termination_sec"></a> [auto\_scaler\_profile\_max\_graceful\_termination\_sec](#input\_auto\_scaler\_profile\_max\_graceful\_termination\_sec) | Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`. | `string` | `"600"` | no |
| <a name="input_auto_scaler_profile_max_node_provisioning_time"></a> [auto\_scaler\_profile\_max\_node\_provisioning\_time](#input\_auto\_scaler\_profile\_max\_node\_provisioning\_time) | Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`. | `string` | `"15m"` | no |
| <a name="input_auto_scaler_profile_max_unready_nodes"></a> [auto\_scaler\_profile\_max\_unready\_nodes](#input\_auto\_scaler\_profile\_max\_unready\_nodes) | Maximum Number of allowed unready nodes. Defaults to `3`. | `number` | `3` | no |
| <a name="input_auto_scaler_profile_max_unready_percentage"></a> [auto\_scaler\_profile\_max\_unready\_percentage](#input\_auto\_scaler\_profile\_max\_unready\_percentage) | Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`. | `number` | `45` | no |
| <a name="input_auto_scaler_profile_new_pod_scale_up_delay"></a> [auto\_scaler\_profile\_new\_pod\_scale\_up\_delay](#input\_auto\_scaler\_profile\_new\_pod\_scale\_up\_delay) | For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to `10s`. | `string` | `"10s"` | no |
| <a name="input_auto_scaler_profile_scale_down_delay_after_add"></a> [auto\_scaler\_profile\_scale\_down\_delay\_after\_add](#input\_auto\_scaler\_profile\_scale\_down\_delay\_after\_add) | How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`. | `string` | `"10m"` | no |
| <a name="input_auto_scaler_profile_scale_down_delay_after_delete"></a> [auto\_scaler\_profile\_scale\_down\_delay\_after\_delete](#input\_auto\_scaler\_profile\_scale\_down\_delay\_after\_delete) | How long after node deletion that scale down evaluation resumes. Defaults to the value used for `scan_interval`. | `string` | `null` | no |
| <a name="input_auto_scaler_profile_scale_down_delay_after_failure"></a> [auto\_scaler\_profile\_scale\_down\_delay\_after\_failure](#input\_auto\_scaler\_profile\_scale\_down\_delay\_after\_failure) | How long after scale down failure that scale down evaluation resumes. Defaults to `3m`. | `string` | `"3m"` | no |
| <a name="input_auto_scaler_profile_scale_down_unneeded"></a> [auto\_scaler\_profile\_scale\_down\_unneeded](#input\_auto\_scaler\_profile\_scale\_down\_unneeded) | How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`. | `string` | `"10m"` | no |
| <a name="input_auto_scaler_profile_scale_down_unready"></a> [auto\_scaler\_profile\_scale\_down\_unready](#input\_auto\_scaler\_profile\_scale\_down\_unready) | How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`. | `string` | `"20m"` | no |
| <a name="input_auto_scaler_profile_scale_down_utilization_threshold"></a> [auto\_scaler\_profile\_scale\_down\_utilization\_threshold](#input\_auto\_scaler\_profile\_scale\_down\_utilization\_threshold) | Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`. | `string` | `"0.5"` | no |
| <a name="input_auto_scaler_profile_scan_interval"></a> [auto\_scaler\_profile\_scan\_interval](#input\_auto\_scaler\_profile\_scan\_interval) | How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`. | `string` | `"10s"` | no |
| <a name="input_auto_scaler_profile_skip_nodes_with_local_storage"></a> [auto\_scaler\_profile\_skip\_nodes\_with\_local\_storage](#input\_auto\_scaler\_profile\_skip\_nodes\_with\_local\_storage) | If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_auto_scaler_profile_skip_nodes_with_system_pods"></a> [auto\_scaler\_profile\_skip\_nodes\_with\_system\_pods](#input\_auto\_scaler\_profile\_skip\_nodes\_with\_system\_pods) | If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`. | `bool` | `true` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`. By default automatic-upgrades are turned off. Note that you cannot use the `patch` upgrade channel and still specify the patch version using `kubernetes_version`. See [the documentation](https://learn.microsoft.com/en-us/azure/aks/auto-upgrade-cluster) for more information | `string` | `null` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | (Optional) Enable Azure Policy Addon to manage and report on the compliance state of your Kubernetes clusters from one place. More information [can be found in the documentation](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes) | `bool` | `true` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | (Optional) The Client ID (appId) for the Service Principal used for the AKS deployment | `string` | `""` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | (Optional) The Client Secret (password) for the Service Principal used for the AKS deployment | `string` | `""` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom AKS Name, it will overide the generate name if set | `string` | `""` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | (Optional) Existing azurerm\_log\_analytics\_workspace to attach azurerm\_log\_analytics\_solution. Providing the config disables creation of azurerm\_log\_analytics\_workspace. | `string` | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Should the Kubernetes Auto Scaler be enabled for this Node Pool?. Requires that the type is set to VirtualMachineScaleSets | `bool` | `false` | no |
| <a name="input_enable_host_encryption"></a> [enable\_host\_encryption](#input\_enable\_host\_encryption) | Enable Host Encryption for default node pool. Changing this forces a new resource to be created. Encryption at host feature must be enabled on the subscription: https://docs.microsoft.com/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli | `bool` | `false` | no |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip) | (Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false. Changing this forces a new resource to be created | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | Enable HTTP Application Routing Addon (forces recreation). | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (Optional) The type of identity used for the managed cluster. Conflicts with `client_id` and `client_secret`. Possible values are `SystemAssigned` and `UserAssigned`. If `UserAssigned` is set, an `identity_ids` must be set as well. | `string` | `"SystemAssigned"` | no |
| <a name="input_ingress_application_gateway_enabled"></a> [ingress\_application\_gateway\_enabled](#input\_ingress\_application\_gateway\_enabled) | Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster? | `bool` | `false` | no |
| <a name="input_ingress_application_gateway_id"></a> [ingress\_application\_gateway\_id](#input\_ingress\_application\_gateway\_id) | The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_ingress_application_gateway_name"></a> [ingress\_application\_gateway\_name](#input\_ingress\_application\_gateway\_name) | The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_ingress_application_gateway_subnet_cidr"></a> [ingress\_application\_gateway\_subnet\_cidr](#input\_ingress\_application\_gateway\_subnet\_cidr) | The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_ingress_application_gateway_subnet_id"></a> [ingress\_application\_gateway\_subnet\_id](#input\_ingress\_application\_gateway\_subnet\_id) | The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_key_vault_secrets_provider"></a> [key\_vault\_secrets\_provider](#input\_key\_vault\_secrets\_provider) | "Enable AKS built-in Key Vault secrets provider. If enabled, an identity is created by the AKS itself and exported from this module."<br>secret\_rotation\_enabled - (Optional) Should the secret store CSI driver on the AKS<br>secret\_rotation\_interval - (Optional) The interval to poll for secret rotation. This attribute is only set when secret\_rotation is true and defaults to 2m | <pre>object({<br>    secret_rotation_enabled  = optional(bool)<br>    secret_rotation_interval = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region | `string` | `null` | no |
| <a name="input_load_balancer_profile_enabled"></a> [load\_balancer\_profile\_enabled](#input\_load\_balancer\_profile\_enabled) | (Optional) Enable a load\_balancer\_profile block. This can only be used when load\_balancer\_sku is set to `standard`. | `bool` | `false` | no |
| <a name="input_load_balancer_profile_idle_timeout_in_minutes"></a> [load\_balancer\_profile\_idle\_timeout\_in\_minutes](#input\_load\_balancer\_profile\_idle\_timeout\_in\_minutes) | (Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120` inclusive. | `number` | `30` | no |
| <a name="input_load_balancer_profile_managed_outbound_ip_count"></a> [load\_balancer\_profile\_managed\_outbound\_ip\_count](#input\_load\_balancer\_profile\_managed\_outbound\_ip\_count) | (Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive | `number` | `null` | no |
| <a name="input_load_balancer_profile_managed_outbound_ipv6_count"></a> [load\_balancer\_profile\_managed\_outbound\_ipv6\_count](#input\_load\_balancer\_profile\_managed\_outbound\_ipv6\_count) | (Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of `1` to `100` (inclusive). The default value is `0` for single-stack and `1` for dual-stack. Note: managed\_outbound\_ipv6\_count requires dual-stack networking. To enable dual-stack networking the Preview Feature Microsoft.ContainerService/AKS-EnableDualStack needs to be enabled and the Resource Provider re-registered, see the documentation for more information. https://learn.microsoft.com/en-us/azure/aks/configure-kubenet-dual-stack?tabs=azure-cli%2Ckubectl#register-the-aks-enabledualstack-preview-feature | `number` | `null` | no |
| <a name="input_load_balancer_profile_outbound_ip_address_ids"></a> [load\_balancer\_profile\_outbound\_ip\_address\_ids](#input\_load\_balancer\_profile\_outbound\_ip\_address\_ids) | (Optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer. | `set(string)` | `null` | no |
| <a name="input_load_balancer_profile_outbound_ip_prefix_ids"></a> [load\_balancer\_profile\_outbound\_ip\_prefix\_ids](#input\_load\_balancer\_profile\_outbound\_ip\_prefix\_ids) | (Optional) The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer. | `set(string)` | `null` | no |
| <a name="input_load_balancer_profile_outbound_ports_allocated"></a> [load\_balancer\_profile\_outbound\_ports\_allocated](#input\_load\_balancer\_profile\_outbound\_ports\_allocated) | (Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between `0` and `64000` inclusive. Defaults to `0` | `number` | `0` | no |
| <a name="input_load_balancer_sku"></a> [load\_balancer\_sku](#input\_load\_balancer\_sku) | (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are `basic` and `standard`. Defaults to `standard`. Changing this forces a new kubernetes cluster to be created. | `string` | `"standard"` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) If `true` local accounts will be disabled. Defaults to `false`. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts). | `bool` | `null` | no |
| <a name="input_log_analytics_workspace_enabled"></a> [log\_analytics\_workspace\_enabled](#input\_log\_analytics\_workspace\_enabled) | Enable the integration of azurerm\_log\_analytics\_workspace and azurerm\_log\_analytics\_solution: https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard | `bool` | `true` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) Maintenance configuration of the managed cluster. | <pre>object({<br>    allowed = list(object({<br>      day   = string<br>      hours = set(number)<br>    })),<br>    not_allowed = list(object({<br>      end   = string<br>      start = string<br>    })),<br>  })</pre> | `null` | no |
| <a name="input_net_profile_dns_service_ip"></a> [net\_profile\_dns\_service\_ip](#input\_net\_profile\_dns\_service\_ip) | (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_net_profile_outbound_type"></a> [net\_profile\_outbound\_type](#input\_net\_profile\_outbound\_type) | (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer. | `string` | `"loadBalancer"` | no |
| <a name="input_net_profile_pod_cidr"></a> [net\_profile\_pod\_cidr](#input\_net\_profile\_pod\_cidr) | (Optional) The CIDR to use for pod IP addresses. This field can only be set when network\_plugin is set to kubenet. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_net_profile_service_cidr"></a> [net\_profile\_service\_cidr](#input\_net\_profile\_service\_cidr) | (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created. | `string` | `"azure"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | (Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | (Optional) Enable or Disable the OIDC issuer URL. Defaults to false. To enable Azure AD Workload Identity oidc\_issuer\_enabled must be set to true. More information [can be found in the documentation] (https://learn.microsoft.com/en-gb/azure/aks/use-oidc-issuer). | `bool` | `true` | no |
| <a name="input_only_critical_addons_enabled"></a> [only\_critical\_addons\_enabled](#input\_only\_critical\_addons\_enabled) | (Optional) Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created. | `bool` | `null` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | Is Open Service Mesh enabled? For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about). | `bool` | `null` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes\_version | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The size of the OS Disk in GB which should be used for each agent in the Node Pool. Changing this forces a new resource to be created | `number` | `50` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. Changing this forces a new resource to be created. | `string` | `"Managed"` | no |
| <a name="input_pod_subnet_id"></a> [pod\_subnet\_id](#input\_pod\_subnet\_id) | (Optional) The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | (Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to `false`. By using a private cluster, you can ensure network traffic between your API server and your node pools remains on the private network only  More information [can be found in the documentation] https://learn.microsoft.com/en-gb/azure/aks/private-clusters#create-a-private-aks-cluster-with-a-public-dns-address | `bool` | `true` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | A custom ssh key to control access to the AKS cluster. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_rbac_aad"></a> [rbac\_aad](#input\_rbac\_aad) | (Optional) Is Azure Active Directory ingration enabled? | `bool` | `true` | no |
| <a name="input_rbac_aad_admin_group_object_ids"></a> [rbac\_aad\_admin\_group\_object\_ids](#input\_rbac\_aad\_admin\_group\_object\_ids) | Object ID of groups with admin access. | `list(string)` | `null` | no |
| <a name="input_rbac_aad_azure_rbac_enabled"></a> [rbac\_aad\_azure\_rbac\_enabled](#input\_rbac\_aad\_azure\_rbac\_enabled) | (Optional) Is Role Based Access Control based on Azure AD enabled? | `bool` | `null` | no |
| <a name="input_rbac_aad_client_app_id"></a> [rbac\_aad\_client\_app\_id](#input\_rbac\_aad\_client\_app\_id) | The Client ID of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_rbac_aad_managed"></a> [rbac\_aad\_managed](#input\_rbac\_aad\_managed) | Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration. | `bool` | `true` | no |
| <a name="input_rbac_aad_server_app_id"></a> [rbac\_aad\_server\_app\_id](#input\_rbac\_aad\_server\_app\_id) | The Server ID of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_rbac_aad_server_app_secret"></a> [rbac\_aad\_server\_app\_secret](#input\_rbac\_aad\_server\_app\_secret) | The Server Secret of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_rbac_aad_tenant_id"></a> [rbac\_aad\_tenant\_id](#input\_rbac\_aad\_tenant\_id) | (Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used. | `string` | `null` | no |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_scale_down_mode"></a> [scale\_down\_mode](#input\_scale\_down\_mode) | (Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. If not specified, it defaults to `Delete`. Possible values include `Delete` and `Deallocate`. Changing this forces a new resource to be created. | `string` | `"Delete"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Standard (which includes the Uptime SLA) | `string` | `"Free"` | no |
| <a name="input_storage_profile_blob_driver_enabled"></a> [storage\_profile\_blob\_driver\_enabled](#input\_storage\_profile\_blob\_driver\_enabled) | (Optional) Is the Blob CSI driver enabled? Defaults to `false` | `bool` | `false` | no |
| <a name="input_storage_profile_disk_driver_enabled"></a> [storage\_profile\_disk\_driver\_enabled](#input\_storage\_profile\_disk\_driver\_enabled) | (Optional) Is the Disk CSI driver enabled? Defaults to `true` | `bool` | `true` | no |
| <a name="input_storage_profile_disk_driver_version"></a> [storage\_profile\_disk\_driver\_version](#input\_storage\_profile\_disk\_driver\_version) | (Optional) Disk CSI Driver version to be used. Possible values are `v1` and `v2`. Defaults to `v1`. | `string` | `"v1"` | no |
| <a name="input_storage_profile_enabled"></a> [storage\_profile\_enabled](#input\_storage\_profile\_enabled) | Enable storage profile | `bool` | `false` | no |
| <a name="input_storage_profile_file_driver_enabled"></a> [storage\_profile\_file\_driver\_enabled](#input\_storage\_profile\_file\_driver\_enabled) | (Optional) Is the File CSI driver enabled? Defaults to `true` | `bool` | `true` | no |
| <a name="input_storage_profile_snapshot_controller_enabled"></a> [storage\_profile\_snapshot\_controller\_enabled](#input\_storage\_profile\_snapshot\_controller\_enabled) | (Optional) Is the Snapshot Controller enabled? Defaults to `true` | `bool` | `true` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | (Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false. Changing this forces a new resource to be created | `bool` | `false` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | (Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false. To enable Azure AD Workload Identity oidc\_issuer\_enabled must be set to true. | `bool` | `false` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_host"></a> [admin\_host](#output\_admin\_host) | The `host` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. The Kubernetes cluster server host. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The `password` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A password or token used to authenticate to the Kubernetes cluster. |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The `username` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A username used to authenticate to the Kubernetes cluster. |
| <a name="output_aks_cluster_id"></a> [aks\_cluster\_id](#output\_aks\_cluster\_id) | The AKS cluster ID created |
| <a name="output_aks_cluster_kubernetes_version"></a> [aks\_cluster\_kubernetes\_version](#output\_aks\_cluster\_kubernetes\_version) | The AKS cluster version |
| <a name="output_aks_cluster_name"></a> [aks\_cluster\_name](#output\_aks\_cluster\_name) | The AKS cluster ID name |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | The OIDC issuer URL that is associated with the cluster. |

## Contact

Atos Europe

to regenerate this `README.md` file run in pwsh, in current directory

` docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module `

` docker stop pre; docker rm pre; docker run -it --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform:nightly run -a `
<!-- END_TF_DOCS -->
