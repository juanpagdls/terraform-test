locals {
  onprem_egress_ip = [
    "180.156.105.0/24",
    "180.102.104.0/21"]
  spn_api = [
    "51.105.242.66",
    "51.138.73.204",
    "40.114.160.224/28"]
  campus_proxy = [
    "193.127.200.187",
    "193.127.200.188",
    "193.127.200.35",
    "193.127.200.36",
    "193.127.200.41",
    "193.127.207.151",
    "193.127.207.153",
    "193.127.207.152",
    "193.127.207.148",
    "193.127.207.149",
    "193.127.207.156",
    "193.127.207.173",
    "193.127.207.183",
    "195.149.215.60",
    "195.149.215.61",
    "195.149.215.232",
    "195.149.215.235",
    "195.149.215.238",
    "195.149.215.225",
    "193.127.193.44",
    "193.127.193.53",
    "193.127.217.10",
    "193.127.229.35",
    "193.127.200.42",
    "193.127.195.0/24",
    "193.127.177.0/24",
    "193.127.207.245"]
  vpn = [
    "146.112.0.0/16"]
  umbrella = [
    "146.112.0.0/16",
    "155.190.0.0/18"]
}

locals {
  name_rule = ["onprem_egress_ip1", 
              "onprem_egress_ip2", 
               "spn_api_1", 
               "spn_api_2", 
               "spn_api_3", 
               "vpn",
               "umbrella",
               "campus_proxy1", 
               "campus_proxy2", 
               "campus_proxy3", 
               "campus_proxy4", 
               "campus_proxy5", 
               "campus_proxy6", 
               "campus_proxy7", 
               "campus_proxy8", 
               "campus_proxy9", 
               "campus_proxy10", 
               "campus_proxy11", 
               "campus_proxy12", 
               "campus_proxy13", 
               "campus_proxy14", 
               "campus_proxy15", 
               "campus_proxy16", 
               "campus_proxy17",
               "campus_proxy18",
               "campus_proxy19",
               "campus_proxy20",
               "campus_proxy21"]
  start_ip_address = ["180.156.105.1", 
                      "180.102.104.1", 
                      "51.105.242.66", 
                      "51.138.73.204", 
                      "40.114.160.225", 
                      "146.112.0.1",
                      "155.190.0.1",
                      "193.127.200.35", 
                      "193.127.200.41", 
                      "193.127.200.187", 
                      "193.127.207.148", 
                      "193.127.207.151", 
                      "193.127.207.156", 
                      "193.127.207.173", 
                      "193.127.207.183", 
                      "195.149.215.60", 
                      "195.149.215.225",
                      "195.149.215.232", 
                      "195.149.215.235", 
                      "195.149.215.238", 
                      "193.127.193.44", 
                      "193.127.193.53", 
                      "193.127.217.10", 
                      "193.127.229.35",
                      "193.127.200.42",
                      "193.127.195.1",
                      "193.127.207.1",
                      "193.127.207.245"]
  end_ip_address = ["180.156.105.254", 
                    "180.102.111.254", 
                    "51.105.242.66", 
                    "51.138.73.204", 
                    "40.114.160.238", 
                    "146.112.255.254",
                    "155.190.63.254",
                    "193.127.200.36", 
                    "193.127.200.41", 
                    "193.127.200.188", 
                    "193.127.207.149", 
                    "193.127.207.153", 
                    "193.127.207.156", 
                    "193.127.207.173", 
                    "193.127.207.183", 
                    "195.149.215.61", 
                    "195.149.215.225", 
                    "195.149.215.232", 
                    "195.149.215.235", 
                    "195.149.215.238", 
                    "193.127.193.44", 
                    "193.127.193.53", 
                    "193.127.217.10", 
                    "193.127.229.35",
                    "193.127.200.42",
                    "193.127.195.254",
                    "193.127.207.254",
                    "193.127.207.245"]
}
