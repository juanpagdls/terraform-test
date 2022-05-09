# STA variables

variable "sta_name" {
  type        = string
  description = "(Required) Specifies the name of the Storage Account. Changing this forces a new resource to be created. Must be globally unique. See CCoE Naming section for all restrictions."
}

variable "kvt_name" {
  type        = string
  description = "(Required) The name of a KVT where manage keys and access policies."
}
variable "account_tier" {
  type        = string
  description = "(Required) Storage account access kind [ Standard | Premium ]."
}
variable "access_tier" {
  type        = string
  description = "(Optional) Storage account access tier for BlobStorage accounts [ Hot | Cool ]"
  default     = "Hot"
}
variable "account_replication_type" {
  type        = string
  description = "(Required)  Storage account replication type [ LRS ZRS GRS RAGRS ]"
}
variable "is_hns_enabled" {
  type        = string
  description = "(Optional) to allow Data Lake GEN 2, you need to set the variable account_kind to StorageV2. Changes this force a new resource."
  default     = true
}
variable "kvt_key_name" {
  type        = string
  description = "(Required) The name of a key from a KVT to connect with the Storage Account Product."
}

variable "key_version" {
  type        = string
  description = "(Optional) The version of a key from a KVT to connect with the Storage Account Product."
  default = null
}

variable "datalake_filesystem_name" {
  type        = string
  description = "(Optional) The name of the initial data lake filesystem name."
}

variable "virtual_network_subnet_ids" {
  type        = list
  description = "(Required) List of ids of subnets that can connect."
}

variable "ip_rules" {
  type        = list
  description = "(Required) List of IP that can connect."
}

variable "bypass" {
  type        = list(string)
  description = "(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default = ["None"]
}


# Settings for diagnostics monitor
variable "analytics_diagnostic_monitor" {
  description = "(Mandatory) The name of the Analytics Diagnostic Monitor for Product."
}
variable "analytics_diagnostic_monitor_blob" {
  description = "(Mandatory) The name of the Analytics Diagnostic Monitor for Product."
}
variable "lwk_name" {
  type        = string
  description = "(Required) The name of the lwk_name."
}
variable "channel" {
  type        = string
  description = "(Optional) Distribution channel to which the associated resource belongs to."
  default     = ""
}

# COMMON variables

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Storage Account."
}

variable "description" {
  type        = string
  description = "(Required) Provide additional context information describing the resource and its purpose."
}

variable "tracking_code" {
  type        = string
  description = "(Required) Allow this resource to be matched against internal inventory systems."
}

variable "cia" {
  type        = string
  description = "(Required) Allows a  proper data classification to be attached to the resource."

}

variable "custom_tags" {
  type        = map
  description = "(Optional) Custom (additional) tags for data lake storage gen2"
  default     = {}
}






