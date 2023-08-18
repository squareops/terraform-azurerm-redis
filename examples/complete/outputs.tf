output "resource_group_id" {
  description = "The ID of the Azure Resource Group."
  value       = module.redis_server.resource_group_id
}

output "resource_group_name" {
  description = "The name of the Azure Resource Group."
  value       = module.redis_server.resource_group_name
}

output "storage_account_id" {
  description = "The ID of the Azure Storage Account used for logs and backups."
  value       = module.redis_server.storage_account_id
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account used for logs and backups."
  value       = module.redis_server.storage_account_name
}

output "redis_cache_ids" {
  description = "The list of IDs of the Azure Redis Cache instances."
  value       = module.redis_server.redis_cache_ids
}

output "redis_cache_names" {
  description = "The list of names of the Azure Redis Cache instances."
  value       = module.redis_server.redis_cache_names
}

output "virtual_network_name" {
  description = "The name of the Azure Virtual Network, if created."
  value       = module.redis_server.virtual_network_name
}

output "subnet_id" {
  description = "The ID of the Azure Subnet, if created for private endpoints."
  value       = module.redis_server.subnet_id
}

output "subnet_name" {
  description = "The name of the Azure Subnet, if created for private endpoints."
  value       = module.redis_server.subnet_name
}

output "private_dns_zone_id" {
  description = "The ID of the Azure Private DNS Zone, if created for Redis Cache."
  value       = module.redis_server.private_dns_zone_id
}

output "private_dns_zone_name" {
  description = "The name of the Azure Private DNS Zone, if created for Redis Cache."
  value       = module.redis_server.private_dns_zone_name
}

output "private_dns_zone_virtual_network_link_id" {
  description = "The ID of the Azure Private DNS Zone Virtual Network Link, if created."
  value       = module.redis_server.private_dns_zone_virtual_network_link_id
}

output "private_dns_zone_virtual_network_link_name" {
  description = "The name of the Azure Private DNS Zone Virtual Network Link, if created."
  value       = module.redis_server.private_dns_zone_virtual_network_link_name
}

output "log_analytics_workspace_id" {
  description = "The ID of the Azure Log Analytics Workspace, if created for diagnostics."
  value       = module.redis_server.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "The name of the Azure Log Analytics Workspace, if created for diagnostics."
  value       = module.redis_server.log_analytics_workspace_name
}

output "diagnostic_setting_id" {
  description = "The ID of the Azure Monitor Diagnostic Setting, if created."
  value       = module.redis_server.diagnostic_setting_id
}

output "diagnostic_setting_name" {
  description = "The name of the Azure Monitor Diagnostic Setting, if created."
  value       = module.redis_server.diagnostic_setting_name
}
