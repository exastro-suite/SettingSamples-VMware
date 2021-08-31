data "vsphere_virtual_machine" "bastion01-template" {
  name          = var.template_bastion01_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "bastion01" {
  name             = var.prov_bastion01_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path

  num_cpus = var.prov_bastion01_cpu_num
  memory   = var.prov_bastion01_mem_num
  guest_id = data.vsphere_virtual_machine.bastion01-template.guest_id


  scsi_type = data.vsphere_virtual_machine.bastion01-template.scsi_type


  network_interface {
    network_id   = data.vsphere_network.network1.id
    adapter_type = "vmxnet3"
  }
  
  network_interface {
    network_id   = data.vsphere_network.VM-Temp-Segment-DMZ.id
    adapter_type = "vmxnet3"
  }
  
  network_interface {
    network_id   = data.vsphere_network.VM-Temp-Segment-INTRA.id
    adapter_type = "vmxnet3"
  }



  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.bastion01-template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.bastion01-template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.bastion01-template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.bastion01-template.id

    customize {
      linux_options {
        host_name = var.prov_bastion01_name
        domain    = "local"
              }

      network_interface {
        ipv4_address = var.prov_bastion01_ipv4_address
        ipv4_netmask = var.prov_bastion01_ipv4_netmask
        
      }
      network_interface {
        ipv4_address = "192.168.10.10"
        ipv4_netmask = "24"
      }
      network_interface {
        ipv4_address = "192.168.20.10"
        ipv4_netmask = "24"
      }
      
      ipv4_gateway = var.prov_bastion01_ipv4_gateway
      
    }
  }
}