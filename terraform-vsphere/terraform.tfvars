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

//template_master = ""
template_worker = "Ubuntu24042ver3"

datastore_master = "Master2-DS"
datastore_worker = "Datastore"

network_master = "VM Network"
network_worker = "VM Network"

gateway = "10.0.100.11"

ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqgU+VhkzqJ80y1x+IWzdsoNGfUgmdVNQa5hZS8UzHRj5mOm/hlD6AsbOokxljM4SjQo5p3x0x6sZLAg8+aQWtAjm/mQC/ImsUGqSf7U2M3IjqMAXhedgv3sMZCJ8YWls5kgmYMysLvEAi2Rd7DuKGoPX/cgzPQ8DW0EZS2MDXT6+DH29aC08cbjnx/K6THqlXj59ftod6yPf3SDsTHbrh4THhGxlTKo67OVeUfakqmsH+KBQ6TA3r6UkM8l1kDtuK3ZLMITQ8q9j+A9d7qrvz0dDN2FhA0Z0n7CpvyNR1SwVY72Vj3whZOMbM428oDXdgArPjGrxAeTuWWr2+S7esi3kxxBtqs9e5cvhCvttItM2MZxu6MKc4+LFZ/7Qot8+255N8AWdeFfk6JwA0FEEeGgejP8U04niCN+rmL2Q0LELzEW/xu7LKW6nio1+s5qjk0DWsGq7gTlr971jOit966YIz8adnsZO0n+Sy3R7ZCERTHmteCXYLlWfkOxeypg4Dw0yYP2QHdxAxKeFsHtGQfdGosi5EH93C4K1iLS/tmNoMKN1fTBzTjweEqie8J/lLG6EuL9t6ZMUZj26IfZ0lmID5Jcj6kXWXiamfeXHSsD9tOJs8grtfL6OO8X7Ux4kwG9mR6f2Jjpfwy+SCIHMw71iD/1vyDcr06dQRAHhkvQ== 2-29@2-29"

# 마스터 추가 배포 (ESXi 호스트별로)
master_vms = {
  # "master6" = { ip = "10.8.0.31", host = "10.8.0.100" },
  # "master7" = { ip = "10.8.0.32", host = "10.8.0.101" }
}

# 워커 추가 배포
worker_vms = {
  "worker04" = "10.8.0.41"
}
