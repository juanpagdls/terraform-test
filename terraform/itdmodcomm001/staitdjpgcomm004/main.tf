module "module-data-lake-storage-gen2-sm" {
  
  #source  = "git::https://github.alm.europe.cloudcenter.corp/sgt-cloudplatform/terraform-azurerm-module-dls-sm.git?ref=v1.4.2"
  source  = "./modules/terraform-azurerm-module-dls-sm-1.4.2"

  name                                = var.sta_name
  resource_group                      = var.resource_group
  kvt_name                            = var.kvt_name
  kvt_key_name                        = var.kvt_key_name
  account_tier                        = var.account_tier
  access_tier                         = var.access_tier
  analytics_diagnostic_monitor        = var.analytics_diagnostic_monitor
  analytics_diagnostic_monitor_blob   = var.analytics_diagnostic_monitor_blob
  lwk_resource_group_name             = var.resource_group
  lwk_name                            = var.lwk_name
  account_replication_type            = var.account_replication_type
  is_hns_enabled                      = var.is_hns_enabled
  datalake_filesystem_name            = var.datalake_filesystem_name
  virtual_network_subnet_ids          = var.virtual_network_subnet_ids
  ip_rules                            = var.ip_rules
  cia                                 = var.cia
  channel                             = var.channel
  description                         = var.description
  tracking_code                       = var.tracking_code

}