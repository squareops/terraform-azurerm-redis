locals {
  region      = "eastus"
  name        = "skaf"
  environment = "prod"
  additional_tags = {
    Owner      = "Organization_Name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "redis_server" {
  source                   = "squareops/redis/azurerm"
  name                     = local.name
  environment              = local.environment
  resource_group_name      = "redis-server" # Specify the name of the resource group to be created
  resource_group_location  = local.region   # Specify the region of the resource group to be created
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

  tags = local.additional_tags
}