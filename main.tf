# Manages resource group
resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Storage Account to keep logs and backups
resource "azurerm_storage_account" "storeacc" {
  count                     = var.data_persistence_enabled ? 1 : 0
  depends_on                = [azurerm_resource_group.default]
  name                      = format("%s%s%s", var.environment, var.name, "stracc")
  resource_group_name       = azurerm_resource_group.default.name
  location                  = azurerm_resource_group.default.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags                      = var.tags
}

# Redis Cache Instance configuration
resource "azurerm_redis_cache" "main" {
  depends_on                    = [azurerm_resource_group.default, azurerm_subnet.snet-ep]
  for_each                      = var.redis_server_settings
  name                          = format("%s-%s-%s", var.environment, var.name, each.key)
  resource_group_name           = azurerm_resource_group.default.name
  location                      = azurerm_resource_group.default.location
  capacity                      = each.value["capacity"]
  family                        = lookup(var.redis_family, each.value.sku_name)
  sku_name                      = each.value["sku_name"]
  enable_non_ssl_port           = each.value["enable_non_ssl_port"]
  minimum_tls_version           = each.value["minimum_tls_version"]
  private_static_ip_address     = each.value["private_static_ip_address"]
  public_network_access_enabled = each.value["public_network_access_enabled"]
  replicas_per_master           = each.value["sku_name"] == "Premium" ? each.value["replicas_per_master"] : null
  shard_count                   = each.value["sku_name"] == "Premium" ? each.value["shard_count"] : null
  subnet_id                     = each.value["sku_name"] == "Premium" ? azurerm_subnet.snet-ep.0.id : null
  zones                         = each.value["zones"]
  tags                          = var.tags

  redis_configuration {
    enable_authentication           = lookup(var.redis_configuration, "enable_authentication", true)
    maxfragmentationmemory_reserved = each.value["sku_name"] == "Premium" || each.value["sku_name"] == "Standard" ? lookup(var.redis_configuration, "maxfragmentationmemory_reserved") : null
    maxmemory_delta                 = each.value["sku_name"] == "Premium" || each.value["sku_name"] == "Standard" ? lookup(var.redis_configuration, "maxmemory_delta") : null
    maxmemory_policy                = lookup(var.redis_configuration, "maxmemory_policy")
    maxmemory_reserved              = each.value["sku_name"] == "Premium" || each.value["sku_name"] == "Standard" ? lookup(var.redis_configuration, "maxmemory_reserved") : null
    notify_keyspace_events          = lookup(var.redis_configuration, "notify_keyspace_events")
    rdb_backup_enabled              = each.value["sku_name"] == "Premium" && var.data_persistence_enabled == true ? true : false
    rdb_backup_frequency            = each.value["sku_name"] == "Premium" && var.data_persistence_enabled == true ? var.data_persistence_backup_frequency : null
    rdb_backup_max_snapshot_count   = each.value["sku_name"] == "Premium" && var.data_persistence_enabled == true ? var.data_persistence_backup_max_snapshot_count : null
    rdb_storage_connection_string   = each.value["sku_name"] == "Premium" && var.data_persistence_enabled == true ? azurerm_storage_account.storeacc.0.primary_blob_connection_string : null
  }

  dynamic "patch_schedule" {
    for_each = var.patch_schedule != null ? [var.patch_schedule] : []
    content {
      day_of_week    = var.patch_schedule.day_of_week
      start_hour_utc = var.patch_schedule.start_hour_utc
    }
  }

  lifecycle {
    ignore_changes = [redis_configuration.0.rdb_storage_connection_string]
  }
}

# Adding Firewall rules for Redis Cache Instance
resource "azurerm_redis_firewall_rule" "name" {
  depends_on          = [azurerm_resource_group.default]
  for_each            = var.firewall_rules != null ? { for k, v in var.firewall_rules : k => v if v != null } : {}
  name                = format("%s_%s_%s", var.environment, var.name, each.key)
  redis_cache_name    = element([for n in azurerm_redis_cache.main : n.name], 0)
  resource_group_name = azurerm_resource_group.default.name
  start_ip            = each.value["start_ip"]
  end_ip              = each.value["end_ip"]
}

# Manages a vnet
resource "azurerm_virtual_network" "default" {
  count               = var.create_vnet ? 1 : 0
  depends_on          = [azurerm_resource_group.default]
  name                = format("%s-%s-%s", var.environment, var.name, "vnet")
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}

# Manages a subnet
resource "azurerm_subnet" "snet-ep" {
  count                                          = var.private_endpoint_enabled ? 1 : 0
  depends_on                                     = [azurerm_resource_group.default]
  name                                           = format("%s-%s-%s", var.environment, var.name, "subnet")
  virtual_network_name                           = var.create_vnet == true ? azurerm_virtual_network.default[0].name : var.vnet_name
  resource_group_name                            = var.create_vnet == true ? azurerm_resource_group.default.name : var.vnet_resource_group_name
  address_prefixes                               = [var.subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_private_dns_zone" "dnszone1" {
  depends_on          = [azurerm_resource_group.default]
  count               = var.private_endpoint_enabled ? 1 : 0
  name                = format("%s-%s%s", var.environment, var.name, "privatelink.redis.cache.windows.net")
  resource_group_name = var.create_vnet == true ? azurerm_resource_group.default.name : var.vnet_resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vent-link1" {
  depends_on            = [azurerm_resource_group.default]
  count                 = var.private_endpoint_enabled ? 1 : 0
  name                  = format("%s-%s%s", var.environment, var.name, "vnet-private-zone-link")
  resource_group_name   = var.create_vnet == true ? azurerm_resource_group.default.name : var.vnet_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone1.0.name
  virtual_network_id    = var.create_vnet == true ? azurerm_virtual_network.default[0].id : var.vnet_id
  tags                  = var.tags
}

resource "azurerm_log_analytics_workspace" "example" {
  depends_on          = [azurerm_redis_cache.main]
  count               = var.diagnostics_enabled ? 1 : 0
  name                = format("%s-%s-%s", var.environment, var.name, "workspace")
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "extaudit" {
  depends_on                 = [azurerm_log_analytics_workspace.example]
  count                      = var.diagnostics_enabled ? 1 : 0
  name                       = format("%s-%s-%s", var.environment, var.name, "redis")
  target_resource_id         = element([for i in azurerm_redis_cache.main : i.id], 0)
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example[0].id
  storage_account_id         = var.data_persistence_enabled ? azurerm_storage_account.storeacc.0.id : null

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [metric]
  }
}