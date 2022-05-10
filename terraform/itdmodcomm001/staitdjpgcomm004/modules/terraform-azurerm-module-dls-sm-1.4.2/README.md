# **Azure Storage Account Data Lake Gen2**

[![Build Status](https://dev.azure.com/SantanderCCoE/CCoE/_apis/build/status/eac.az.blueprints.storage-account-sm-ple?branchName=master)](https://dev.azure.com/SantanderCCoE/CCoE/_build/latest?definitionId=460&branchName=master)

## Overview


### Acronym
Acronym for the storage account is **dls**, check [List of Acronyms](https://confluence.alm.europe.cloudcenter.corp/display/OPTIMUM/Naming+Convention+Excel+Simulator) for a complete list of acronyms


### Description
> Azure Data Lake Storage Gen2 is a set of capabilities dedicated to big data analytics, built on [Azure Blob storage](https://docs.microsoft.com/es-es/azure/storage/blobs/storage-blobs-introduction).

> Data Lake Storage Gen2 converges the capabilities of [Azure Data Lake Storage Gen2](https://docs.microsoft.com/es-es/azure/storage/blobs/data-lake-storage-introduction) with Azure Blob storage. For example, Data Lake Storage Gen2 provides file system semantics, file-level security, and scale. Because these capabilities are built on Blob storage, you'll also get low-cost, tiered storage, with high availability/disaster recovery capabilities.

> **IMPORTANT**: If you want to run this module with a specific version of the Azure provider, it must be established by the client in its versions.tfvars file.<br> <br> Don't use a subnet with table route configured, the module don't work properly with it.<br> <br>If it is required to fix the terraform version, proceed in the same way as with the azure provider.<br><br>This module has been certified with the version of azure provider 3.0.2 and with the version of terraform 1.0.9.

|Configuration|Description|
|:--|:--|
|Supported Services|blob, table, queue, file, web, dfs|
|Supported Protocols|HTTPS|
|Authentication|Azure AD RBAC model should be used to access resources, **access using SAS Tokens should not be used** (not enforced)|

### Public Documentation
[Azure Storage Account Overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview)

[Azure Data Lake Gen2](https://docs.microsoft.com/es-es/azure/storage/blobs/data-lake-storage-introduction)


>[!IMPORTANT]
>Storage Accounts use dedicated private endpoint and associated privatelink DNS zone per service. For example, a storage account enabled for blob and queue  services will need one private endpoint and one private IP address for each service.

>[!IMPORTANT]
>Only Storage Accounts of kind General Purpose V2 (including Data Lake Storage V2) support private Endpoints. Storage Accounts of kind General Purpose V1 need to be [upgraded](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-upgrade?tabs=azure-portal) to V2 before having private endpoints available.

>[!IMPORTANT]
>Certain Storage Account use cases do not support turning on Storage Account firewall as configured by this product. If you plan to use such scenarios, do not use this product to generate the storage account. The following affected scenarios have been identified: [Boot Diagnostics](https://docs.microsoft.com/en-us/azure/virtual-machines/troubleshooting/serial-console-errors), [Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/persisting-shell-storage), [Serial Console](https://docs.microsoft.com/en-us/azure/virtual-machines/troubleshooting/serial-console-errors) and [SQL Audit](https://github.com/MicrosoftDocs/azure-docs/issues/16409).

### Version
|Version|Target SCF|
|:--|:--|
|1.0.0|SM|

### Target Audience
|Audience |Purpose  |
|--|--|
| Cloud Center of Excellence | Understand the Design of this Service |
| Cybersecurity Hub | Understand how the Security Framework is implemented in this Service and who is responsible of each control |
| Service Management Hub | Understand how the Service can be managed according to the Service Management Framework |

### Configuration


|Parameter| Tf Name | Default Value | Type |Mandatory |Others |
|:--|:--:|:--:|:--:|:--:|:--|
|Name| name| N/A | string| yes| Specifies the name of the Storage Account |
|Resource Group Name| resource_group| N/A | string| yes| The name of the resource group in which to create the Storage Account |
|Key Vault Name| kvt_name| N/A | string| yes| The name of a KVT where manage keys and access policies |
|Key Vault Key Name| kvt_key_name | N/A | string| yes| The name of a key from a KVT to connect with the Storage Account Product |
|Account Tier| account_tier| Hot| string| no| Standard/Premium |
|Access Tier| access_tier| Hot| string| no| Hot/Cool |
|Replication Type| account_replication_type | N/A | string | yes| LRS/GRS/RAGS... |
|Allow Data Lake GEN2| is_hns_enabled | true | boolean | no | true to allow Data Lake GEN 2 |
|Lwk Resource Group Name| lwk_resource_group_name | N/A | string | yes | The name of the resource group of the lwk. |
|Lwk Name| lwk_name | N/A | string | yes | TThe name of the lwk_name. |
|Analytics Diagnostic Monitor | analytics_diagnostic_monitor | n/a| string| Yes | Analytics Diagnostic Monitor Name to create for the product.|
|Analytics Diagnostic Monitor for Blob| analytics_diagnostic_monitor_blob | n/a| string| Yes | Analytics Diagnostic Monitor Name to create for the product.|
|Data Lake Filesystem Name| datalake_filesystem_name | N/A | string | yes | The name of the initial data lake filesystem name.|
|Virtual Network Subnet ID| virtual_network_subnet_ids | N/A | string | yes | TList of ids of subnets that can connect.|
|Bypass| bypass | N/A | string | no | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.|
|IP Rules| ip_rules | N/A | string | yes | List of IP that can connect.|
|Tag Channel| channel| N/A | string| no| |
|Tag Description| description| N/A | string| yes| |
|Tag Tracking Code| tracking_code| N/A | string| yes| |
|Tag CIA| cia| N/A | string| yes| Confidentiality-Integrity-Availability |
|Custom (additional) tags| custom_tags | {} | `map`| no| Custom (additional) tags for data lake storage gen2 |


### Usage

Include the next code into your main.tf file:
```hcl
module "storage-account-sm" {

  source = "<Storage Account module source>"
  
  name                       = var.name
  resource_group             = var.resource_group
  kvt_name                   = var.kvt_name
  kvt_key_name               = var.kvt_key_name
  account_tier               = var.account_tier
  access_tier                = var.access_tier
  analytics_diagnostic_monitor  = var.analytics_diagnostic_monitor
  analytics_diagnostic_monitor_blob  = var.analytics_diagnostic_monitor_blob
  lwk_resource_group_name    = var.lwk_resource_group_name
  lwk_name                   = var.lwk_name
  account_replication_type   = var.account_replication_type
  is_hns_enabled             = var.is_hns_enabled
  datalake_filesystem_name   = var.datalake_filesystem_name
  virtual_network_subnet_ids = var.virtual_network_subnet_ids
  ip_rules                   = var.ip_rules
  cia                        = var.cia
  channel                    = var.channel
  description                = var.description
  tracking_code              = var.tracking_code
  custom_tags                = var.custom_tags

}
```

* You can watch more details about [Storage Account configuration parameters](/variables.tf).

### Dependencies
The following resources must exist before the deployment can take place:

* Azure Subscription
* Resource Group
* Azure Active Directory Tenant
* A deployment Service Principal with owner permissions
* A vnet, and a subnet with the endpoint "Microsoft.Storage" enabled


## Architecture
![Architecture diagram](documentation/architecture_diagram.png "Architecture diagram")



### DNS
Consumers of the PostgreSQL service should be able to resolve public FQDN of service to the private IP address associated to the private endpoint. This requires properly registering the private IP in DNS, according to defined DNS architecture for private endpoints usage.

### Network topology
![Network diagram](documentation/network_diagram.png "Network diagram")


### Exposed product endpoints
The following endpoints can be used to consume or manage the Certified Product:

#### Management endpoints (Control Plane)
These endpoints will allow to make changes in the configuration of the Certified Service, change permissions or make application deployments.

|EndPoint|IP/URL  |Protocol|Port|Authorization|
|:-|:-|--|--|:-|
|Azure Resource Management REST API|https://management.azure.com/|HTTPS|443|Azure Active Directory|


#### Consumption endpoints (Data Plane)
These endpoints will allow you to consume the Certified Service from an application perspective.

|EndPoint|IP/URL  |Protocol|Port|Authorization|
|:-|:-|--|--|:-|
|Secured private endpoint, accessible through private IP over public FQDN|https://[storage account name].[service].core.windows.net|HTTPS|443|Authentication and Authorization via Azure AD RBAC model|


# **Security Framework**
This section explains how the different aspects to have into account in order to meet the Security Control Framework for this Certified Service. 

This product has been certified for the [Security Control Framework v1.0.1](https://confluence.alm.europe.cloudcenter.corp/display/CCOESGT/Datalake+Gen2) revision.

## Security issues


### Internal RBAC model

RBAC model available per Storage Account internal resource type:

 - Blobs: AzureAD IAM ->  OK
 - Files: In preview status -> issue
 - Tables: non AzureAD IAM -> issue
 - Queues: optional AzureAD IAM -> issue

Azure Files supports authorization with Azure AD over SMB for domain-joined VMs only (preview).

https://docs.microsoft.com/bs-latn-ba/azure/storage/common/storage-auth-aad#azure-ad-authorization-over-smb-for-azure-files

Shared Access Signature (SAS) is an alternative way of authenticating & authorizing requests.

## Security Controls based on Security Control Framework

### Foundation (**F**) Controls for Rated Workloads
|SF#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SF1|IAM on all accounts|Azure AD RBAC model for products certifies right level of access to resource. SAS token are not allowed, although allow Shared Key Access is not disabled due to it's a setting in preview state.| CCoE, Entity|
|SF2|MFA on account|This is governed by Azure AD.|CISO, CCoE, Entity|
|SF3|Platform Activity Logs & Security Monitoring|Platform logs and security monitoring provided by Platform. Azure Security Center and Azure Defender for Storage may be used for security monitoring on the Paas, although this is not enforced.|CISO, CCoE, Entity|
|SF4|Malware Protection on IaaS|Since this is a **PaaS** service, Malware Protection on IaaS doesn't apply|CISO, CCoE, Entity|
|<span style="color:red">SF5</span>|Authenticate all connections|Since this is a **PaaS** service, server certificate is configured by CSP. User authentication is done via Azure Active Directory. Anonimous authentication is disabled in certified product.|CCoE, Entity|
|SF6|Isolated environments at network level|The product's virtual firewall denies incoming connections allowing only access from onPrem, Campus Proxy, VPN and SPN API.|CISO, CCoE, Entity|
|SF7|Security Configuration & Patch Management|Since this is a PaaS service, product upgrade and patching is done by CSP|CCoE, Entity|
|SF8|Privileged Access Management|**Data Plane**: Access to data plane is not considered Privileged Access **Control Plane**: Access to the control plane is considered Privileged Access and is governed as per the Azure Management Endpoint Privileged Access Management policy|CISO, CCoE|


### Application (**P**) Controls for Rated Workloads
|SP#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SP1|Resource tagging for all resources|Product includes all required tags in the deployment template|CISO, CCoE|
|SP2|Segregation of Duties|N/A|CISO, CCoE, Entity|
|SP3|Vulnerability Management|Since this is a **PaaS** service, Vulnerability Management is done by CSP|CISO, CCoE, Entity|
|<span style="color:red">SP4</span>|Service Logs and Security Monitoring|Product is connected to Log Analytics for activity and security monitoring. Azure Security Center and Azure Defender for Storage may be used for security monitoring on the Paas, although this is not enforced.|CISO, CCoE, Entity|
|SP5|Network Security|**SP5.1**: The product's virtual firewall allows OnPrem connectivity. Devops team is responsible for configuring the virtual firewall of the product to restrict access from onpremise. There is no connectivity from PaaS to onprem. **SP5.2**:  Devops team is responsible for configuring the virtual firewall of the product to allow required connectivity between CSP Private Zones of different entities. **SP5.3**: Devops team is responsible for configuring the virtual firewall of the product to allow required connectivity between CSP Private Zones of the same entity. **SP5.4**: The product's virtual firewall denies incoming connections allowing only access from onPrem, Campus Proxy, VPN and SPN API. **SP5.5**: Doesn't apply as no outbound traffic is generated from the service. **SP5.6**: Doesn't apply.|CISO, CCoE, Entity|
|SP6|Advanced Malware Protection on IaaS|Since this is a **PaaS** service, Advanced Malware Protection on IaaS doesn't apply.|CISO, CCoE, Entity|
|SP7|Cyber incidents management & Digital evidences gathering|Isolate infrastructure product is possible with product's virtual firewall.|CISO, Entity|
|SP8|Encrypt data in transit over public interconnections|Certified Product enables only https traffic and TLS variable is setted to 1.2.|CCoE, Entity|
|SP9|	Static Application Security Testing|Since there is no applicaton code in this PaaS service, Static Application Security Testing doesn't apply.|Entity|

### Medium (**M**) Controls for Rated Workloads
|SM#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SM1|IAM|Azure AD RBAC model for products certifies right level of access to resource. SAS token are not allowed, although allow Shared Key Access is not disabled due to it's a setting in preview state.|CCoE, Entity|
|SM2|Encrypt data at rest|Certified Product encrypt data at rest.|CCoE|
|SM3|Encrypt data in transit over private interconnections|Certified Product enables only https traffic and TLS variable is setted to 1.2.|CCoE, Entity|
|SM4|Control resource geographical location|The product tocation is inherited from the resource group.|CCoE, Entity|

### Advanced (**A**) Controls for Rated Workloads
|A#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SA1|IAM|Azure AD RBAC model for products certifies right level of access to resource. SAS token are not allowed, although allow Shared Key Access is not disabled due to it's a setting in preview state.|CCoE, Entity|
|SA2|Encrypt data at rest|Certified Product encrypt data at rest.|CCoE|
|SA3|Encrypt data in transit over private interconnections|Certified Product enables only https traffic and TLS variable is setted to 1.2.|CCoE, Entity|
|SA4|Santander managed keys with HSM and BYOK|Santander-managed key is used for encrypt data at rest. Key Vault is setted during the deployment process.|CISO, CCoE, Entity|
|SA5|Control resource geographical location|The product tocation is inherited from the resource group.|CCoE, Entity|
|SA6|Cardholder and auth sensitive data|Entity is responsable to identify workloads and components processing cardholder and auth sensitive data and apply the security measures to comply with the Payment Card Industry Data Security Standard (PCI-DSS).|Entity|
|SA7|Access control to data with MFA|This is governed by Azure AD.|CISO, CCoE, Entity|

**Exit Plan**

AzCopy is a command-line utility that you can use to copy blobs or files to or from a storage account. 
* [Get started with AZ Copy](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10)
* Please, review the section **Download Files** at [Transfer data with AzCopy and file storage](
https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files)

# **Product Artifacts**

|Package Name|Version|
|:--|:--|
|terraform-azurerm-module-dls-sm|1.4.0|

This section explain the structure and elements that represent the artifacts of product.

|Folder|Name|Description
|--|:-|--|
|Documentation|network_diagram.png|Network topology diagram|
|Documentation|architecture_diagram.png|Architecture diagram|
|Documentation|Changelog.md|Log of change file|
|Root|Readme.md|Product documentation file|
|Root|main.tf|Terraform file to use in pipeline to build and release a product|
|Root|outputs.tf|Terraform file to use in pipeline to check output|
|Root|variables.tf|Terraform file to use in pipeline to configure product|

# Migration from module iac.az.modules.storage-account-sm

In order to migrate the storage account from the old module to this blueprint, which includes the private endpoint creation, you need to import your storage account into your TFstate file. There can be different calls to this blueprint, so let's see them:

## Updating your storage account  and creating a private endpoint blueprint by using directly the main.tf file provided in this repository

1. If you have a TFstate file where you have your previous storage account depoyment, set the backend file to use it.

2. Run the following command within the folder where you have the main.tf file:
```hcl
terraform import azurerm_storage_account_customer_managed_key.encryption_byok "<your_storage_account_id>"
```
## Updating your storage account and creating a private endpoint blueprint by using the critical repository (when available)

1. If you have a TFstate file where you have your previous workload deployment, set the backend file to use it.

2. Run the following command within the folder where you have the main.tf file:
```hcl
terraform import module.sta-critical.azurerm_storage_account_customer_managed_key.encryption_byok "<your_storage_account_id>"
```

## Updating your storage account and creating a private endpoint blueprint by using any other main.tf file that you configure where you call this blueprint

1. If you have a TFstate file where you have your previous workload deployment, set the backend file to use it.

2. Run the following command within the folder where you have the main.tf file:
```hcl
terraform import module.<module_name>.azurerm_storage_account_customer_managed_key.encryption_byok "<your_storage_account_id>"
```

# **Links to internal documentation**

**Reference documents** :  
- [List of Acronyms](https://confluence.alm.europe.cloudcenter.corp/display/OPTIMUM/Naming+Convention+Excel+Simulator)
- [Naming Convention for Repos](https://confluence.ci.gsnet.corp/display/OPTIMUM/Naming+Convention+for+Azure+resources)
- [Repo module strategy for terraform](https://confluence.ci.gsnet.corp/display/OPTIMUM/Repo+module+strategy+for+Terraform)
- [Product Portfolio](https://confluence.ci.gsnet.corp/display/OPTIMUM/CCoE+Product+Portfolio)
- [Naming Convention for Azure Resources](https://confluence.ci.gsnet.corp/display/OPTIMUM/Naming+Convention+for+Azure+resources)
