resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  datastore_id     = var.datastore.id
  resource_pool_id = var.resource_pool_id

  # ESXi 직접 지정할 경우만 사용
  dynamic "host_system_id" {
    for_each = var.host_system_id != null ? [1] : []
    content {
      host_system_id = var.host_system_id
    }
  }

  num_cpus = var.cpu
  memory   = var.memory
  guest_id = var.template.guest_id
  scsi_type = var.template.scsi_type

  network_interface {
    network_id   = var.network.id
    adapter_type = var.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.template.disks[0].size
    thin_provisioned = true
    eagerly_scrub    = false
  }

  clone {
    template_uuid = var.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = "local"
      }

      network_interface {
        ipv4_address = var.ip_address
        ipv4_netmask = 8
      }

      ipv4_gateway = "10.8.0.1"
    }
  }

  extra_config = {
    "guestinfo.userdata"          = base64encode(file("${path.module}/cloud-init/user-data"))
    "guestinfo.userdata.encoding" = "base64"
  }

  wait_for_guest_net_timeout = 0
}
