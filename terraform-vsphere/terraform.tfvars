// 변수에 실제 값 할당
# vCenter 인증 정보
vsphere_user     = "administrator@fisa.com"
vsphere_password = "VMware1!"
vsphere_server   = "192.168.0.155"

# vSphere 리소스 이름
esxi_100 = "10.8.0.100"
esxi_101 = "10.8.0.101"

datacenter_master = "Paasta-DC"
datacenter_worker = "Fisa_ce_Datacenter"
resource_pool_name = "Paasta-RS"

template_master = ""
template_worker = ""

datastore_master = ""
datastore_worker = "Datastore"

network_master = "VM Network"
network_worker = "VM Network"

# 마스터 추가 배포 (ESXi 호스트별로)
master_vms = {
  "master6" = { ip = "10.8.0.31", host = "10.8.0.100" },
  "master7" = { ip = "10.8.0.32", host = "10.8.0.101" }
}

# 워커 추가 배포
worker_vms = {
  "worker04" = "10.8.0.41",
  "worker05" = "10.8.0.42"
}
