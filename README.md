# Azure Cache for Redis
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
Azure Cache for Redis is a managed caching service provided by Microsoft Azure, designed to enhance application performance through efficient data caching. Leveraging the capabilities of the open-source Redis cache, this service offers a range of features to optimize your application's responsiveness and reduce the load on databases.

### Key Features

- **High-Performance Caching:** Azure Cache for Redis operates with minimal latency and high throughput. By storing frequently accessed data in-memory, it minimizes the need to retrieve data from the underlying data store, resulting in faster data access.

- **Support for Data Structures:** This service fully supports Redis' versatile data structures, including strings, lists, sets, and hashes. This flexibility makes it suitable for a wide array of caching scenarios and data manipulation tasks.

- **Scalability:** Azure Cache for Redis is a fully managed service that handles replication, scaling, and failover automatically. It offers multiple cache tiers, from basic to premium, enabling you to select the optimal resource level for your application's demands.

- **Security Measures:** The service provides security features like Virtual Network (VNet) integration, firewall rules, and access control policies. This ensures that your cached data remains protected and accessible only to authorized users.

- **Data Persistence:** To ensure data durability and rapid cache warm-up after restarts, Azure Cache for Redis offers data persistence options. These options allow you to store cache data on disk, mitigating data loss risks.

- **Monitoring and Analytics:** Built-in monitoring and analytics tools offer insights into cache performance, usage patterns, and potential issues. These tools empower you to optimize your caching strategy and troubleshoot performance bottlenecks effectively.

- **Seamless Integration:** Azure Cache for Redis seamlessly integrates with various Azure services and programming languages. This facilitates the incorporation of caching into your applications, regardless of the tech stack you use.

- **Global Distribution:** Utilizing Redis' built-in data replication and Azure's global network, you can create globally distributed cache instances. This improves performance for users spread across different geographical locations.

- **Versatile Use Cases:** This service is suitable for a variety of use cases, such as session caching, real-time analytics, leaderboards, and job queue management. Its versatility makes it an essential tool for optimizing diverse application types.

## Usage Example
```hcl
module "redis_server" {
  source                   = "squareops/redis/azurerm"
  name                     = "skaf-redis"
  environment              = "prod"
  resource_group_name      = "redis-server" # Specify the name of the resource group to be created
  resource_group_location  = "eastus"       # Specify the region of the resource group to be created
  create_vnet              = "true"         # set "true" to create a fresh vnet for the database server.
  vnet_resource_group_name = "demo-rg"      # If vnet creation is set to false, specify the resource group name where vnet is present.
  vnet_name                = "test-vnet"    # If vnet creation is set to false, specify the vnet name here.
  vnet_id                  = ""             # If vnet creation is set to false, specify the vnet id here.
  vnet_address_space       = "10.0.0.0/16"  # vnet will be created with specified CIDR's. Do not specify while passing existing vnet resource group, name & id
  subnet_cidr              = "10.0.3.0/28"
  data_persistence_enabled = true
  # Specify `shard_count` to create on the Redis Cluster
  redis_server_settings = {
    redis = {
      sku_name            = "Premium"
      capacity            = 1
      shard_count         = 1
      zones               = ["1", "2", "3"]
      enable_non_ssl_port = true
    }
  }
  # Azure Cache for Redis instances are configured with the following default Redis configuration values:
  redis_configuration = {
    maxmemory_reserved = 1
    maxmemory_delta    = 1
    maxmemory_policy   = "allkeys-lru"
  }
  # Clustered caches are patched one shard at a time. 
  # The Patch Window lasts for 5 hours from the `start_hour_utc`
  patch_schedule = {
    day_of_week    = "Saturday"
    start_hour_utc = 10
  }
  firewall_rules = {
    access_to_azure = {
      start_ip = "10.0.3.0"
      end_ip   = "10.0.3.255"
    }
  }
  private_endpoint_enabled = true
  diagnostics_enabled      = true

  tags = {}
}
```
Refer [examples](https://github.com/squareops/terraform-azurerm-redis/tree/main/examples/complete) for more details

## Permissions

Required permissions to create resources from this module are mentioned [here](https://github.com/squareops/terraform-azurerm-redis/tree/main/roles.md)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.extaudit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_dns_zone.dnszone1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vent-link1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_redis_cache.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_firewall_rule.name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |
| [azurerm_resource_group.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storeacc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.snet-ep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vnet"></a> [create\_vnet](#input\_create\_vnet) | Create a virtual network. | `bool` | `false` | no |
| <a name="input_data_persistence_backup_frequency"></a> [data\_persistence\_backup\_frequency](#input\_data\_persistence\_backup\_frequency) | The Backup Frequency in Minutes. Only supported on Premium SKU's. Possible values are: `15`, `30`, `60`, `360`, `720` and `1440` | `number` | `60` | no |
| <a name="input_data_persistence_backup_max_snapshot_count"></a> [data\_persistence\_backup\_max\_snapshot\_count](#input\_data\_persistence\_backup\_max\_snapshot\_count) | The maximum number of snapshots to create as a backup. Only supported for Premium SKU's | `number` | `1` | no |
| <a name="input_data_persistence_enabled"></a> [data\_persistence\_enabled](#input\_data\_persistence\_enabled) | Enable data persistence for Redis Cache. | `bool` | `false` | no |
| <a name="input_diagnostics_enabled"></a> [diagnostics\_enabled](#input\_diagnostics\_enabled) | Enable diagnostics settings. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment tag for resources. | `string` | `"dev"` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | Range of IP addresses to allow firewall connections. | <pre>map(object({<br>    start_ip = string<br>    end_ip   = string<br>  }))</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name tag for resources. | `string` | `"my-app"` | no |
| <a name="input_patch_schedule"></a> [patch\_schedule](#input\_patch\_schedule) | The window for redis maintenance. The Patch Window lasts for 5 hours from the `start_hour_utc` | <pre>object({<br>    day_of_week    = string<br>    start_hour_utc = number<br>  })</pre> | `null` | no |
| <a name="input_private_endpoint_enabled"></a> [private\_endpoint\_enabled](#input\_private\_endpoint\_enabled) | Enable private endpoint for Redis. | `bool` | `false` | no |
| <a name="input_redis_configuration"></a> [redis\_configuration](#input\_redis\_configuration) | Configuration for the Redis instance | <pre>object({<br>    enable_authentication           = optional(bool)<br>    maxmemory_reserved              = optional(number)<br>    maxmemory_delta                 = optional(number)<br>    maxmemory_policy                = optional(string)<br>    maxfragmentationmemory_reserved = optional(number)<br>    notify_keyspace_events          = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | The SKU family/pricing group to use. Valid values are `C` (for `Basic/Standard` SKU family) and `P` (for `Premium`) | `map(any)` | <pre>{<br>  "Basic": "C",<br>  "Premium": "P",<br>  "Standard": "C"<br>}</pre> | no |
| <a name="input_redis_server_settings"></a> [redis\_server\_settings](#input\_redis\_server\_settings) | optional redis server setttings for both Premium and Standard/Basic SKU | <pre>map(object({<br>    capacity                      = number<br>    sku_name                      = string<br>    enable_non_ssl_port           = optional(bool)<br>    minimum_tls_version           = optional(string)<br>    private_static_ip_address     = optional(string)<br>    public_network_access_enabled = optional(string)<br>    replicas_per_master           = optional(number)<br>    shard_count                   = optional(number)<br>    zones                         = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location for the Azure resource group. | `string` | `"East US"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the Azure resource group. | `string` | `"my-resource-group"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | CIDR block for the subnet. | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet for Premium Redis. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources. | `map(string)` | `{}` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Address space for the virtual network. | `string` | `""` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | ID of an existing virtual network for private endpoint. | `string` | `""` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of an existing virtual network. | `string` | `""` | no |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Resource group name for an existing virtual network. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_diagnostic_setting_id"></a> [diagnostic\_setting\_id](#output\_diagnostic\_setting\_id) | The ID of the Azure Monitor Diagnostic Setting, if created. |
| <a name="output_diagnostic_setting_name"></a> [diagnostic\_setting\_name](#output\_diagnostic\_setting\_name) | The name of the Azure Monitor Diagnostic Setting, if created. |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | The ID of the Azure Log Analytics Workspace, if created for diagnostics. |
| <a name="output_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#output\_log\_analytics\_workspace\_name) | The name of the Azure Log Analytics Workspace, if created for diagnostics. |
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | The ID of the Azure Private DNS Zone, if created for Redis Cache. |
| <a name="output_private_dns_zone_name"></a> [private\_dns\_zone\_name](#output\_private\_dns\_zone\_name) | The name of the Azure Private DNS Zone, if created for Redis Cache. |
| <a name="output_private_dns_zone_virtual_network_link_id"></a> [private\_dns\_zone\_virtual\_network\_link\_id](#output\_private\_dns\_zone\_virtual\_network\_link\_id) | The ID of the Azure Private DNS Zone Virtual Network Link, if created. |
| <a name="output_private_dns_zone_virtual_network_link_name"></a> [private\_dns\_zone\_virtual\_network\_link\_name](#output\_private\_dns\_zone\_virtual\_network\_link\_name) | The name of the Azure Private DNS Zone Virtual Network Link, if created. |
| <a name="output_redis_cache_ids"></a> [redis\_cache\_ids](#output\_redis\_cache\_ids) | The list of IDs of the Azure Redis Cache instances. |
| <a name="output_redis_cache_names"></a> [redis\_cache\_names](#output\_redis\_cache\_names) | The list of names of the Azure Redis Cache instances. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The ID of the Azure Resource Group. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Azure Resource Group. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the Azure Storage Account used for logs and backups. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the Azure Storage Account used for logs and backups. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the Azure Subnet, if created for private endpoints. |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The name of the Azure Subnet, if created for private endpoints. |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the Azure Virtual Network, if created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribute & Issue Report

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/squareops/terraform-azurerm-redis/issues) on GitHub
  2. Search to check if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Make sure to provide enough context and details.

## License

Apache License, Version 2.0, January 2004 (https://www.apache.org/licenses/LICENSE-2.0)

## Support Us

To support our GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/squareops/)

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Staring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).