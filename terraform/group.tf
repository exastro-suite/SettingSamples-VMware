resource "nsxt_policy_group" "VM-Temp-Bastion-Member" {
  display_name = "VMware-Model-BastionMember"
  description  = "Terraform provisioned Group"

  criteria {
    ipaddress_expression {
      ip_addresses = [ var.bastion_ip ]
    }
  }
}

resource "nsxt_policy_group" "VM-Temp-Server-Group" {
  display_name = "VMware-Model-ServerGroup"
  description  = "Terraform provisioned Group"

  criteria {
    ipaddress_expression {
      ip_addresses = [ "192.168.10.1-192.168.10.254","192.168.20.1-192.168.20.254"]
    }
  }
}


resource "nsxt_policy_group" "VM-Temp-Web-Member" {
  display_name = "VMware-Model-Web-Member"
  description  = "Terraform provisioned Group"

  criteria {
    ipaddress_expression {
      ip_addresses = [ "192.168.10.1-192.168.10.2" ]
    }
  }
}
