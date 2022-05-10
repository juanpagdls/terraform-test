# **Module name: terraform-azurerm-module-irw**

## **Overview**

### Acronym: **irw**

### **Description**

Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. You can use IP network rules to allow access from specific public internet IP address ranges by creating IP network rules. These rules grant access to specific internet-based services and on-premises networks and blocks general internet traffic.

### **Configuration**
The product supports the following custom configuration:

| Parameter                                                                      |        Tf Name        |  Type  | Mandatory | Others |
| :----------------------------------------------------------------------------- | :-------------------: | :----: | :-------: | :----- |
| Virtual Network Rules                 |    network_rules     | String | Required  | ""     |
| Ip Rules                                                                      |       ip_rules       | String | Required  | ""     |

### **Subresources List**


#### Complete subresources List:

| Ip Whitelist Subresource Name                    | Resource type                                  | Ip Rule/Firewall Whitelist                                                                                                                                                   |
| --------------------------------------------- | ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Ip Rules Whitelist (Your own service)       | Microsoft.Storage/servicename          | N/A                                                                                                                                                          |
| Azure Storage                                 | Microsoft.Storage/storageAccounts              |ip_rules |
| Azure Data Lake Storage Gen2                  | Microsoft.Storage/storageAccounts              |ip_rules |
| Azure Cosmos DB                               | Microsoft.AzureCosmosDB/databaseAccounts       |ip_rules |
| Azure Database for PostgreSQL - Single server | Microsoft.DBforPostgreSQL/servers              |firewall_rule |
| Azure Database for MySQL                      | Microsoft.DBforMySQL/servers                   | firewall_rule                                                                                                                                                    |
| Azure Service Bus                             | Microsoft.ServiceBus/namespaces                | ip_rules                                                                                                                                                      |


> **Take into account:** The Subresources list can be modified/updated, we recommend visit the link below in case of any error occurs.

### Whitelist of IPs

|Scenario| per Workload | per Entity (Local CCoE) | Common |Gathered IPs 2021-01-13 |
|:--|:--:|:--:|:--:|:--:|
|Deployment| | Azure DevOps (self-hosted agents) | Multi-Cloud on-prem egress Ips|  CloudBees OCP.CCC <br>180.156.105.0/24|
|Deployment| | VDI's | VDI's on-prem egress Ips|  VDI's development access <br>180.102.104.0/21|
|Deployment| | Other ALM (ej. github.com) | Azure DevOps (Azure hosted)| |
|Deployment| | | SPNAPI egress IPs (e.g. north fw subscription)| 51.105.242.66 <br>51.138.73.204 <br>40.114.160.224/28|
|Ops| | Entity campus proxy (O365 proxy) | Common campus proxy (e.g. CGS O365 proxy)| SanHQ. Usuarios. <br>193.127.193.44<br>193.127.193.53<br>SanHQ. O365<br>193.127.193.53<br>193.127.193.44<br>Santander consumer España<br>193.127.217.10<br>Santander consumer Europa<br>193.127.229.35<br>SAM usuarios<br>193.127.200.187-188<br>Ucloud<br>193.127.200.35<br>193.127.200.36<br>SGT Usuarios<br>193.127.207.151<br>193.127.207.153<br>SGT O365<br>193.127.207.152<br>193.127.207.148<br>193.127.207.149<br>193.127.207.156<br>193.127.207.173<br>193.127.207.183<br>BCE Usuarios<br>195.149.215.60<br>195.149.215.61<br>BCE O365<br>195.149.215.232<br>195.149.215.235<br>195.149.215.238<br>195.149.215.225|
|Ops| | VPN (e.g. entity VPN)| VPN (e.g. SaaS proxy: Umbrella split-tunnel)| 146.112.0.0/16|
|Workload components|egress Ips (for products without UDR) | Entity North firewalls| Servers proxy (https): umbrella, symantec, on-prem|https://knowledge.broadcom.com/external/article?legacyId=tech244697|

Web Security Service egress IP addresses for EMEA.
Protected traffic is tunneled through the Symantec Web Security Service (WSS). The egress IP address viewed by web servers is no longer the egress IP address of.


### Usage

Include the next code into your main.tf file:
```hcl
module "whitelist" {
    source = "git::https://github.alm.europe.cloudcenter.corp/sgt-cloudplatform/terraform-azurerm-module-irw.git"
}
```

To apply ip_rules, the module where the ip list is found must be invoked.
```hcl
   ip_rules = distinct(compact(concat(module.whitelist.ip_whitelist)))
```
In case a firewall rule has to be applied, the following configuration must be entered in the network firewall rules section.
```hcl
resource "terraform_resource_template_name" "rule_name" {
  count               = length (module.whitelist.ip_whitelist_name_rule)
  name                = module.whitelist.ip_whitelist_name_rule[count.index]
  start_ip_address    = module.whitelist.ip_whitelist_start_rule[count.index]
  end_ip_address      = module.whitelist.ip_whitelist_end_rule[count.index]
}
```

## Public documentation

- [Azure Ip Whitelist](https://docs.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#grant-access-from-an-internet-ip-range)

- [Azure Firewall and Virtual Networks](https://docs.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal#grant-access-from-an-internet-ip-range)

- [Terraform Storage Account Network Rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

### **Version**
| Version |
| :------ |
| 1.1.1     |

### **Dependencies**
The following resources must exist before the deployment can take place:

Resources given by the Cloud Competence Center that need to be in place:
- Azure Subscription.
- Resource Group.
- Vnet & subnet with enforce_private_link_service_network_policies set to true.
- All the resources you want to set the network rules.


### **Target Audience**
| Audience                   | Purpose                               |
| -------------------------- | ------------------------------------- |
| Cloud Center of Excellence | Understand the Design of this Service |

- **GitHub Repository:** [terraform-azurerm-module-irw](https://github.alm.europe.cloudcenter.corp/sgt-cloudplatform/terraform-azurerm-module-irw.git)
