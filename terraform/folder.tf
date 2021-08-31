resource "vsphere_folder" "folder" {
  path          = "VMware-Model"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}