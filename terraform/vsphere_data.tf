data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "netadapter" {
  name          = var.netadapter_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "set1_template" {
  name          = var.set1_templatename
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "set2_template" {
  name          = var.set2_templatename != "" ? var.set2_templatename : var.set1_templatename
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "set3_template" {
  name          = var.set3_templatename != "" ? var.set3_templatename : var.set1_templatename
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "bastion_template" {
  name          = var.bastion_templatename
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "external_adapter" {
  name          = var.external_adapter_name
  datacenter_id = data.vsphere_datacenter.dc.id
}