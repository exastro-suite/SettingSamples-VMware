# VM作成Loop版
resource "vsphere_virtual_machine" "prov_intance" {
  count = "${var.set1_vm_count}"
  name = "${var.set1_vmname_prefix}-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path

  # VMスペック
  num_cpus = var.set1_cpu_num
  memory   = var.set1_mem_num
  guest_id = data.vsphere_virtual_machine.set1_template.guest_id

  # VMのテンプレート指定
  scsi_type = data.vsphere_virtual_machine.set1_template.scsi_type
  
  # 接続先ネットワークとアダプタ
  network_interface {
    network_id   = data.vsphere_network.netadapter.id
    adapter_type = "vmxnet3"
  }

  # VMのディスク指定
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.set1_template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.set1_template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.set1_template.disks.0.thin_provisioned
  }

  # 指定したテンプレートからクローン
  clone {
    template_uuid = data.vsphere_virtual_machine.set1_template.id

    customize {
      linux_options {
        host_name = "${var.set1_vmname_prefix}-${count.index}"
        domain    = "local"
      }

      network_interface {
        ipv4_address = "${var.ipv4_1st_to_3rd_octet}.${local.set1_ip_count_from + count.index}"
        ipv4_netmask = 24
      }

      ipv4_gateway = var.set1_gateway_ip
    }
  }
}