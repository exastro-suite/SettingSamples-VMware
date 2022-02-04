# NSX-T Manager
variable "nsx_manager" {}
variable "nsxtmg_username" {}
variable "nsxtmg_password" {}

# Transport Zones
variable "overlay_tz" {}

#Edge cluster node
variable "edge_cluster_name" {}
variable "edge_node_1_name" {}
variable "edge_node_2_name" {}

# Tier0 GW
variable "tier0_display_name" {}


# Tier1 GW
variable "tier1_display_name" {}


# segment
variable "segment_display_name" {}
variable "segment_cidr" {}