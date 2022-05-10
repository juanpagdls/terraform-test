# terraform {
#   required_version = ">= 0.12.29"
# }

locals  {
  ip_whitelist = (compact(concat(local.onprem_egress_ip,local.spn_api,local.campus_proxy,local.vpn,local.umbrella)))
  ip_whitelist_name_rule = (compact(concat(local.name_rule)))
  ip_whitelist_start_rule = (compact(concat(local.start_ip_address)))
  ip_whitelist_end_rule = (compact(concat(local.end_ip_address)))
}

