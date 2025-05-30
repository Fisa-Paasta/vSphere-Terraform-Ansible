# 마스터용 데이터센터 조회
data "vsphere_datacenter" "master_dc" {
  name = var.datacenter_master
}

# 워커용 데이터센터 조회
data "vsphere_datacenter" "worker_dc" {
  name = var.datacenter_worker
}

# 워커용 리소스풀
data "vsphere_resource_pool" "worker_pool" {
  name          = var.resource_pool_name
  datacenter_id = data.vsphere_datacenter.worker_dc.id
}

# 마스터용 ESXi 호스트
data "vsphere_host" "esxi_100" {
  name          = var.esxi_100
  datacenter_id = data.vsphere_datacenter.master_dc.id
}

data "vsphere_host" "esxi_101" {
  name          = var.esxi_101
  datacenter_id = data.vsphere_datacenter.master_dc.id
}

# 템플릿
# data "vsphere_virtual_machine" "master_template" {
#   name          = var.template_master
#   datacenter_id = data.vsphere_datacenter.master_dc.id
# }

data "vsphere_virtual_machine" "worker_template" {
  name          = var.template_worker
  datacenter_id = data.vsphere_datacenter.worker_dc.id
}

# 데이터스토어
data "vsphere_datastore" "master_datastore" {
  name          = var.datastore_master
  datacenter_id = data.vsphere_datacenter.master_dc.id
}

data "vsphere_datastore" "worker_datastore" {
  name          = var.datastore_worker
  datacenter_id = data.vsphere_datacenter.worker_dc.id
}

# 네트워크
data "vsphere_network" "master_network" {
  name          = var.network_worker
  datacenter_id = data.vsphere_datacenter.master_dc.id
}

data "vsphere_network" "worker_network" {
  name          = var.network_master
  datacenter_id = data.vsphere_datacenter.worker_dc.id
}