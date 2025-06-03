terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.2.0"
    }
  }
}

module "masters" {
  source           = "./modules/vm"
  for_each         = var.master_vms
  vm_name          = each.key
  ip_address       = each.value.ip
  gateway          = var.gateway
  host_system_id   = each.value.host == "10.8.0.100" ? data.vsphere_host.esxi_100.id : data.vsphere_host.esxi_101.id
  resource_pool_id = each.value.host == "10.8.0.100" ? data.vsphere_host.esxi_100.resource_pool_id : data.vsphere_host.esxi_101.resource_pool_id
  datastore        = data.vsphere_datastore.master_datastore
  network          = data.vsphere_network.master_network
  template         = data.vsphere_virtual_machine.master_template // 임시 값인 worker_template
  cpu              = 2
  memory           = 4096
  ssh_key          = var.ssh_key
}

module "workers" {
  source           = "./modules/vm"
  for_each         = var.worker_vms
  vm_name          = each.key
  ip_address       = each.value
  gateway          = var.gateway
  host_system_id   = null
  resource_pool_id = data.vsphere_resource_pool.worker_pool.id
  datastore        = data.vsphere_datastore.worker_datastore
  network          = data.vsphere_network.worker_network
  template         = data.vsphere_virtual_machine.worker_template
  cpu              = 2
  memory           = 4096
  ssh_key          = var.ssh_key
}
