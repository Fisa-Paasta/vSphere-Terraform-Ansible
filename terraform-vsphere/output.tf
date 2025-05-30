output "master_ips" {
  value = { for k, v in module.masters : k => v.ip }
}

output "worker_ips" {
  value = { for k, v in module.workers : k => v.ip }
}
