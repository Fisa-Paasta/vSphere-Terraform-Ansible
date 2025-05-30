resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  datastore_id     = var.datastore.id
  resource_pool_id = var.resource_pool_id
  host_system_id   = var.host_system_id

  # ESXi 직접 지정할 경우만 사용
  # dynamic "host_system_id" {
  #   for_each = var.host_system_id != null ? [1] : []
  #   content {
  #     host_system_id = var.host_system_id
  #   }
  # }

  num_cpus  = var.cpu
  memory    = var.memory
  guest_id  = var.template.guest_id
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
  }

  extra_config = {
    "guestinfo.userdata" = base64encode(templatefile("${path.module}/../../cloud-init/user-data.tmpl", {
      hostname = var.vm_name
      ssh_key  = var.ssh_key
    }))
    "guestinfo.userdata.encoding" = "base64"

    "guestinfo.metadata" = base64encode(templatefile("${path.module}/../../cloud-init/metadata.tmpl", {
      hostname   = var.vm_name
      ip_address = var.ip_address
      gateway    = var.gateway
    }))
    "guestinfo.metadata.encoding" = "base64"
  }


  wait_for_guest_net_timeout = 60
}
