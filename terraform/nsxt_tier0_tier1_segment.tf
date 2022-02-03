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
  display_name         = var.tier0_display_name
  description          = "Tier-0 provisioned by Terraform"
  failover_mode        = "NON_PREEMPTIVE"
  default_rule_logging = false
  enable_firewall      = false
  ha_mode              = "ACTIVE_STANDBY"
  edge_cluster_path    = data.nsxt_policy_edge_cluster.edge_cluster.path
} 

resource "nsxt_policy_tier1_gateway" "tier1_gw" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = var.tier1_display_name
  edge_cluster_path         = data.nsxt_policy_edge_cluster.edge_cluster.path
  failover_mode             = "NON_PREEMPTIVE"
  default_rule_logging      = "false"
  enable_firewall           = "true"
  enable_standby_relocation = "false"
  tier0_path                = nsxt_policy_tier0_gateway.tier0_gw.path
  route_advertisement_types = ["TIER1_CONNECTED","TIER1_IPSEC_LOCAL_ENDPOINT"] 
}


resource "nsxt_policy_segment" "segment" {
  display_name        = var.segment_display_name
  description         = "Terraform provisioned Segment"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path   = nsxt_policy_tier1_gateway.tier1_gw.path
  
  subnet {
    cidr        = var.segment_cidr
  }
}


