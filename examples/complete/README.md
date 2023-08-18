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

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redis_server"></a> [redis\_server](#module\_redis\_server) | squareops/redis/azurerm | n/a |

## Resources

No resources.

## Inputs

No inputs.

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
