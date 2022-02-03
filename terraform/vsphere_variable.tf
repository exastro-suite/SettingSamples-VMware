#variable_vsphere
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_datacenter" {}
variable "vsphere_datastore" {}
variable "vsphere_cluster" {}


# set共通の変数
variable "vsphere_folder" {
    type    = string
    default = "ita_managed_folder"
}

variable "external_adapter_name" {}
variable "netadapter_name" {}

variable "ipv4_1st_to_3rd_octet" {}
variable "ipv4_4th_octet_count_from" {
    default = 10
    type = number
}

# set1 用の変数
variable "set1_vm_count" {
    type    = number
    default = 0
}
variable "set1_vmname_prefix" {
    type = string
}
variable "set1_cpu_num" {}
variable "set1_mem_num" {}
variable "set1_templatename" {}

variable "set1_gateway_ip" {}

# set2 用の変数
variable "set2_vm_count" {
    type    = number
    default = 0
}
variable "set2_vmname_prefix" {
    type = string
}
variable "set2_cpu_num" {}
variable "set2_mem_num" {}
variable "set2_templatename" {}
variable "set2_gateway_ip" {}


# set3 用の変数
variable "set3_vm_count" {
    type    = number
    default = 0
}
variable "set3_vmname_prefix" {
    type = string
}
variable "set3_cpu_num" {}
variable "set3_mem_num" {}
variable "set3_templatename" {}
variable "set3_gateway_ip" {}


#踏み台サーバ用の変数
variable "bastion_templatename" {}
variable "bastion_name" {}
variable "bastion_cpu_num" {}
variable "bastion_mem_num" {}
variable "basiton_external_address"{}
variable "bastion_netmask" {}
variable "bastion_gateway" {}
variable "bastion_local_address" {}


locals {
  set1_ip_count_from = var.ipv4_4th_octet_count_from
  set2_ip_count_from = local.set1_ip_count_from + 10
  set3_ip_count_from = local.set1_ip_count_from + 20
}
