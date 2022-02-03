resource "vsphere_virtual_machine" "bastion" {
  name             = var.bastion_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path

  num_cpus = var.bastion_cpu_num
  memory   = var.bastion_mem_num
  guest_id = data.vsphere_virtual_machine.bastion_template.guest_id
  scsi_type = data.vsphere_virtual_machine.bastion_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.external_adapter.id
    adapter_type = "vmxnet3"
  }
  
  network_interface {
    network_id   = data.vsphere_network.netadapter.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.bastion_template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.bastion_template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.bastion_template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.bastion_template.id

    customize {
      linux_options {
        host_name = var.bastion_name
        domain    = "local"
      }

      network_interface {
        ipv4_address = var.basiton_external_address
        ipv4_netmask = var.bastion_netmask
      }  

      network_interface {
        ipv4_address = var.bastion_local_address
        ipv4_netmask = "24"
      }
      
      ipv4_gateway = var.bastion_gateway
      
    }
  }
}