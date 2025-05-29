output "master_ips" {
  value = { for vm in vsphere_virtual_machine.master : vm.name => vm.default_ip_address }
}

output "worker_ips" {
  value = { for vm in vsphere_virtual_machine.worker : vm.name => vm.default_ip_address }
}
