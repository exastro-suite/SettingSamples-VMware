data "nsxt_policy_service" "icmp_all_service" {
  display_name = "ICMP ALL"
}

data "nsxt_policy_service" "http_service" {
  display_name = "HTTP"
}

data "nsxt_policy_service" "https_service" {
  display_name = "HTTPS"
}


data "nsxt_policy_service" "SSH_service" {
  display_name = "SSH"
}


resource "nsxt_policy_security_policy" "security_policy" {
  display_name = "VMware-Model-FW-policy"
  description  = "Terraform provisioned Security Policy"
  category     = "Application"
  locked       = false
  stateful     = true
  tcp_strict   = false

  rule {
    display_name       = "Bastion-ServerGroup-allow"
    source_groups      = [ nsxt_policy_group.VM-Temp-Bastion-Member.path ]
    destination_groups = [ nsxt_policy_group.VM-Temp-Server-Group.path ]
    action             = "ALLOW"
    logged             = false
  }
  
  rule {
    display_name       = "ServerGroup-Bastion-allow"
    source_groups      = [ nsxt_policy_group.VM-Temp-Server-Group.path]
    destination_groups = [ nsxt_policy_group.VM-Temp-Bastion-Member.path ]
    action             = "ALLOW"
    logged             = false
  }
  
  rule {
    display_name       = "Any-ServerGroup-allow"
    destination_groups = [ nsxt_policy_group.VM-Temp-Server-Group.path ]
    services           = [data.nsxt_policy_service.icmp_all_service.path,data.nsxt_policy_service.http_service.path,data.nsxt_policy_service.https_service.path,data.nsxt_policy_service.SSH_service.path]
    action             = "ALLOW"
    logged             = false
  }
  
    rule {
    display_name       = "Bastion-Any-allow"
    source_groups      = [ nsxt_policy_group.VM-Temp-Server-Group.path ]
    action             = "ALLOW"
    logged             = false
  }
  
  rule {
    display_name       = "Default-Deny"
    action             = "DROP"
    logged             = false
  }   
 
}
