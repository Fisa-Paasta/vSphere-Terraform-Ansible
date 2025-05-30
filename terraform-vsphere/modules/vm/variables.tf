variable "vm_name" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "gateway" {
  type = string
}

variable "host_system_id" {
  type = string
  default = null
}

variable "resource_pool_id" {
  type = string
}

variable "datastore" {
  type = any
}

variable "network" {
  type = any
}

variable "template" {
  type = any
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "ssh_key" {
  type = string
}