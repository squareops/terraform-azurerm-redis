output "resource_group_id" {
  description = "The ID of the Azure Resource Group."
  value       = azurerm_resource_group.default.id
}

output "resource_group_name" {
  description = "The name of the Azure Resource Group."
  value       = azurerm_resource_group.default.name
}

output "storage_account_id" {
  description = "The ID of the Azure Storage Account used for logs and backups."
  value       = azurerm_storage_account.storeacc[0].id
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account used for logs and backups."
  value       = azurerm_storage_account.storeacc[0].name
}

output "redis_cache_ids" {
  description = "The list of IDs of the Azure Redis Cache instances."
  value       = [for cache in azurerm_redis_cache.main : cache.id]
}

output "redis_cache_names" {
  description = "The list of names of the Azure Redis Cache instances."
  value       = [for cache in azurerm_redis_cache.main : cache.name]
}

output "virtual_network_name" {
  description = "The name of the Azure Virtual Network, if created."
  value       = var.create_vnet == true ? azurerm_virtual_network.default[0].name : var.vnet_name
}

output "subnet_id" {
  description = "The ID of the Azure Subnet, if created for private endpoints."
  value       = azurerm_subnet.snet-ep[0].id
}

output "subnet_name" {
  description = "The name of the Azure Subnet, if created for private endpoints."
  value       = azurerm_subnet.snet-ep[0].name
}

output "private_dns_zone_id" {
  description = "The ID of the Azure Private DNS Zone, if created for Redis Cache."
  value       = azurerm_private_dns_zone.dnszone1[0].id
}

output "private_dns_zone_name" {
  description = "The name of the Azure Private DNS Zone, if created for Redis Cache."
  value       = azurerm_private_dns_zone.dnszone1[0].name
}

output "private_dns_zone_virtual_network_link_id" {
  description = "The ID of the Azure Private DNS Zone Virtual Network Link, if created."
  value       = azurerm_private_dns_zone_virtual_network_link.vent-link1[0].id
}

output "private_dns_zone_virtual_network_link_name" {
  description = "The name of the Azure Private DNS Zone Virtual Network Link, if created."
  value       = azurerm_private_dns_zone_virtual_network_link.vent-link1[0].name
}

output "log_analytics_workspace_id" {
  description = "The ID of the Azure Log Analytics Workspace, if created for diagnostics."
  value       = azurerm_log_analytics_workspace.example[0].id
}

output "log_analytics_workspace_name" {
  description = "The name of the Azure Log Analytics Workspace, if created for diagnostics."
  value       = azurerm_log_analytics_workspace.example[0].name
}

output "diagnostic_setting_id" {
  description = "The ID of the Azure Monitor Diagnostic Setting, if created."
  value       = azurerm_monitor_diagnostic_setting.extaudit[0].id
}

output "diagnostic_setting_name" {
  description = "The name of the Azure Monitor Diagnostic Setting, if created."
  value       = azurerm_monitor_diagnostic_setting.extaudit[0].name
}
