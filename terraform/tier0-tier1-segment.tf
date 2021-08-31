# Data Sources we need for reference later
data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = var.overlay_tz
}

data "nsxt_policy_edge_cluster" "edge_cluster" {
  display_name = var.edge_cluster_name
}
 
data "nsxt_policy_edge_node" "edge_node_1" {
  edge_cluster_path = data.nsxt_policy_edge_cluster.edge_cluster.path
  display_name      = var.edge_node_1_name
}
 
data "nsxt_policy_edge_node" "edge_node_2" {
  edge_cluster_path = data.nsxt_policy_edge_cluster.edge_cluster.path
  display_name      = var.edge_node_2_name
}
 
resource "nsxt_policy_tier0_gateway" "tier0_gw" {
  display_name         = "VMware-Model-Tier0"
  description          = "Tier-0 provisioned by Terraform"
  failover_mode        = "NON_PREEMPTIVE"
  default_rule_logging = false
  enable_firewall      = false
  ha_mode              = "ACTIVE_STANDBY"
  edge_cluster_path    = data.nsxt_policy_edge_cluster.edge_cluster.path
} 

resource "nsxt_policy_tier1_gateway" "tier1_gw_dmz" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = "VMware-Model-Tier1-DMZ"
  edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster.path
  failover_mode             = "NON_PREEMPTIVE"
  default_rule_logging      = "false"
  enable_firewall           = "true"
  enable_standby_relocation = "false"
  tier0_path                = nsxt_policy_tier0_gateway.tier0_gw.path
  route_advertisement_types = ["TIER1_CONNECTED","TIER1_IPSEC_LOCAL_ENDPOINT"] 
}

resource "nsxt_policy_tier1_gateway" "tier1_gw_inter" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = "VMware-Model-Tier1-INTRA"
  edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster.path
  failover_mode             = "NON_PREEMPTIVE"
  default_rule_logging      = "false"
  enable_firewall           = "true"
  enable_standby_relocation = "false"
  tier0_path                = nsxt_policy_tier0_gateway.tier0_gw.path
  route_advertisement_types = ["TIER1_CONNECTED","TIER1_IPSEC_LOCAL_ENDPOINT"] 
}


resource "nsxt_policy_segment" "segment_dmz" {
  display_name        = "VMware-Model-Segment-DMZ"
  description         = "Terraform provisioned Segment"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path   = nsxt_policy_tier1_gateway.tier1_gw_dmz.path
  
  subnet {
    cidr        = "192.168.10.254/24"
  }
}

resource "nsxt_policy_segment" "segment_inter" {
  display_name        = "VMware-Model-Segment-INTRA"
  description         = "Terraform provisioned Segment"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path   = nsxt_policy_tier1_gateway.tier1_gw_inter.path
  
  subnet {
    cidr        = "192.168.20.254/24"
  }
}

