terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" { 
  features{}
}

############################## Modules ##############################
module "whitelist" {
  source = "git::https://github.alm.europe.cloudcenter.corp/sgt-cloudplatform/terraform-azurerm-module-irw"
}

############################## Data ##############################
data "azurerm_resource_group" "rsg" {
  name = var.resource_group
}

data "azurerm_key_vault" "kvt" {
  name                = var.kvt_name
  resource_group_name = data.azurerm_resource_group.rsg.name
}

data "azurerm_key_vault_key" "datagenerated" {
  name         = var.kvt_key_name
  key_vault_id = data.azurerm_key_vault.kvt.id

  depends_on = [azurerm_key_vault_key.generated]
}

data "azurerm_log_analytics_workspace" "law" {
  name                = var.lwk_name
  resource_group_name = var.lwk_resource_group_name

  depends_on          = [data.azurerm_resource_group.rsg]
}

data "azurerm_storage_account" "datastorage_account_service" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rsg.name

  depends_on = [azurerm_storage_account.storage_account_service]
}

############################## Resources ##############################
resource "azurerm_key_vault_key" "generated" {
  count = substr(var.cia,0,1) == "A" ? 0 : 1
  name         = var.kvt_key_name
  key_vault_id = data.azurerm_key_vault.kvt.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [data.azurerm_key_vault.kvt]
}

resource "azurerm_storage_account" "storage_account_service" {
  name                      = var.name
  resource_group_name       = data.azurerm_resource_group.rsg.name
  location                  = data.azurerm_resource_group.rsg.location
  account_kind              = "StorageV2"
  account_tier              = var.account_tier
  access_tier               = var.access_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true
  is_hns_enabled            = var.is_hns_enabled
  min_tls_version           = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
    bypass                     = var.bypass
    ip_rules = distinct(compact(concat(var.ip_rules,module.whitelist.ip_whitelist)))
  }

  tags = merge({
    cost_center   = data.azurerm_resource_group.rsg.tags["cost_center"]
    product       = data.azurerm_resource_group.rsg.tags["product"]
    channel       = var.channel
    description   = var.description
    tracking_code = var.tracking_code
    cia           = var.cia
  }, var.custom_tags)
}

# Disabled until the Terraform ARM provider fix a bug added in 2.11 version and not corredted yet (2.18)
resource "azurerm_storage_data_lake_gen2_filesystem" "datalake2fs" {

  name               = var.datalake_filesystem_name
  storage_account_id = azurerm_storage_account.storage_account_service.id
/*
  properties = {
    hello = "aGVsbG8="
  }
*/
  depends_on = [azurerm_storage_account.storage_account_service] 
}

resource "azurerm_key_vault_access_policy" "kvt_access_policy" {
  key_vault_id = data.azurerm_key_vault.kvt.id

  tenant_id = azurerm_storage_account.storage_account_service.identity.0.tenant_id
  object_id = azurerm_storage_account.storage_account_service.identity.0.principal_id

  key_permissions = [
    "Get", "WrapKey", "UnwrapKey", "Encrypt", "Decrypt"
  ]

  depends_on = [data.azurerm_storage_account.datastorage_account_service, data.azurerm_key_vault.kvt]
}

resource "azurerm_storage_account_customer_managed_key" "sta_mkey" {
  storage_account_id = azurerm_storage_account.storage_account_service.id
  key_vault_id       = data.azurerm_key_vault.kvt.id
  key_name           = var.kvt_key_name
  key_version        = substr(var.cia,0,1) == "A" ? var.key_version : azurerm_key_vault_key.generated[0].version

  depends_on = [data.azurerm_storage_account.datastorage_account_service, data.azurerm_key_vault.kvt, data.azurerm_key_vault_key.datagenerated, azurerm_key_vault_access_policy.kvt_access_policy]
}


resource "azurerm_monitor_diagnostic_setting" "sta" {
  name                        = var.analytics_diagnostic_monitor
  target_resource_id          = azurerm_storage_account.storage_account_service.id
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.law.id

  metric {
    category = "Transaction"
    retention_policy {
      enabled = true
      days    = "30"
    }
  }
  
  depends_on                  = [azurerm_storage_account.storage_account_service, data.azurerm_log_analytics_workspace.law]
}

resource "azurerm_monitor_diagnostic_setting" "blob" {
  name                       = var.analytics_diagnostic_monitor_blob
  target_resource_id         = "${azurerm_storage_account.storage_account_service.id}/blobServices/default"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id

  log {
    category = "StorageRead"
    retention_policy {
      enabled = true
      days    = "30"
    }
  }
  log {
    category = "StorageWrite"
    retention_policy {
      enabled = true
      days    = "30"
    }
  }
  log {
    category = "StorageDelete"
    retention_policy {
      enabled = true
      days    = "30"
    }
  }
  metric {
    category = "Transaction"
    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  depends_on                = [azurerm_storage_account.storage_account_service, data.azurerm_log_analytics_workspace.law]
}

