data "nsxt_policy_lb_app_profile" "app_http" {
  type         = "HTTP"
  display_name = "default-http-lb-app-profile"
}

resource "nsxt_policy_lb_service" "lb_service" {
  display_name      = "VMware-Model-LB"
  description       = "Terraform provisioned Service"
  connectivity_path = nsxt_policy_tier1_gateway.tier1_gw_dmz.path
  size              = "SMALL"
  enabled           = true
  error_log_level   = "ERROR"
}  

resource "nsxt_policy_lb_pool" "lb_pool" {
  display_name         = "VMware-Model-WEB-Pool"
  description          = "Terraform provisioned LB Pool"
  algorithm            = "ROUND_ROBIN"
  min_active_members   = 1
  active_monitor_path  = "/infra/lb-monitor-profiles/default-icmp-lb-monitor"
  member_group {
    group_path         = nsxt_policy_group.VM-Temp-Web-Member.path
    allow_ipv4         = true
  }
  snat {
    type = "AUTOMAP"
  }
  tcp_multiplexing_number  = 6
}

resource "nsxt_policy_lb_virtual_server" "lb_vserver" {
  display_name               = "VMware-Model-LBVServer"
  description                = "Terraform provisioned Virtual Server"
  access_log_enabled         = true
  application_profile_path   = data.nsxt_policy_lb_app_profile.app_http.path
  service_path               = nsxt_policy_lb_service.lb_service.path
  pool_path                  = nsxt_policy_lb_pool.lb_pool.path
  enabled                    = true
  ip_address                 = "192.168.10.100"
  ports                      = ["80"]
}

