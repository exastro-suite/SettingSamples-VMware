#variable_vsphere
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_datacenter" {}
variable "vsphere_datastore" {}
variable "vsphere_cluster" {}

#variable_web01
variable "template_web01_name" {}
variable "prov_web01_name" {}
variable "prov_web01_cpu_num" {}
variable "prov_web01_mem_num" {}


#variable_web02
variable "template_web02_name" {}
variable "prov_web02_name" {}
variable "prov_web02_cpu_num" {}
variable "prov_web02_mem_num" {}


#variable_ap01
variable "template_ap01_name" {}
variable "prov_ap01_name" {}
variable "prov_ap01_cpu_num" {}
variable "prov_ap01_mem_num" {}


#variable_db01
variable "template_db01_name" {}
variable "prov_db01_name" {}
variable "prov_db01_cpu_num" {}
variable "prov_db01_mem_num" {}

#variable_bastion
variable "template_bastion01_name" {}
variable "prov_bastion01_name" {}
variable "vsphere_network" {}
variable "prov_bastion01_cpu_num" {}
variable "prov_bastion01_mem_num" {}
variable "prov_bastion01_ipv4_address" {}
variable "prov_bastion01_ipv4_netmask" {}
variable "prov_bastion01_ipv4_gateway" {}