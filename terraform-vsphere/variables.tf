# vCenter 인증 정보
variable "vsphere_user" {
  type = string
}
variable "vsphere_password" {
  type = string
  sensitive = true
}
variable "vsphere_server" {
  type = string
}

# vSphere 리소스 식별자
variable "datacenter_master" {
  type = string
}
variable "datacenter_worker" {
  type = string
}

variable "resource_pool_name" {
  type = string
}

# variable "cluster" {
#   type = string
# }

# variable "template_master" {
#   type = string
# }

variable "template_worker" {
  type = string
}

variable "datastore_master" {
  type = string
}

variable "datastore_worker" {
  type = string
}

variable "network_master" {
  type = string
}

variable "network_worker" {
  type = string
}

variable "gateway" {
  type    = string
}

variable "esxi_100" {
  type = string
}
variable "esxi_101" {
  type = string
}

variable "ssh_key" {
  type = string
}

# VM 설정
variable "master_vms" {
  type = map(object({
    ip   = string
    host = string
  }))
}

variable "worker_vms" {
  type = map(string)
}