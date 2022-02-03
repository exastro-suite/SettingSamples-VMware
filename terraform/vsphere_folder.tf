resource "vsphere_folder" "folder" {
  path          =  var.vsphere_folder
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}