output "ip_whitelist" {
  value = (compact(concat(local.onprem_egress_ip,local.spn_api,local.campus_proxy,local.vpn,local.umbrella)))
}

output "ip_whitelist_name_rule" {
  value = (compact(concat(local.name_rule)))
}

output "ip_whitelist_start_rule" {
  value = (compact(concat(local.start_ip_address)))
}

output "ip_whitelist_end_rule" {
  value = (compact(concat(local.end_ip_address)))
}
