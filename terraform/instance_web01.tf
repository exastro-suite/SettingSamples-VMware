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

data "vsphere_network" "VM-Temp-Segment-DMZ" {
  name          = "VMware-Model-Segment-DMZ"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network1" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "VM-Temp-Segment-INTRA" {
  name          = "VMware-Model-Segment-INTRA"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "web01-template" {
  name          = var.template_web01_name
  datacenter_id = data.vsphere_datacenter.dc.id
  
}


resource "vsphere_virtual_machine" "web01" {
  name             = var.prov_web01_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path

  num_cpus = var.prov_web01_cpu_num
  memory   = var.prov_web01_mem_num
  guest_id = data.vsphere_virtual_machine.web01-template.guest_id


  scsi_type = data.vsphere_virtual_machine.web01-template.scsi_type


  network_interface {
    network_id   = data.vsphere_network.VM-Temp-Segment-DMZ.id
    adapter_type = "vmxnet3"
  }


  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.web01-template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.web01-template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.web01-template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.web01-template.id

    customize {
      linux_options {
        host_name = var.prov_web01_name
        domain    = "local"
       
      }

      network_interface {
        ipv4_address = "192.168.10.1"
        ipv4_netmask = "24"

      }
      ipv4_gateway = "192.168.10.254"
    }
  }
}