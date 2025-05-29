#!/usr/bin/env python3
import json
import subprocess
import os

# Terraform output 호출
output = subprocess.check_output(["terraform", "output", "-json"], cwd="../terraform-vsphere")
parsed = json.loads(output)

masters = parsed.get("master_ips", {}).get("value", {})
workers = parsed.get("worker_ips", {}).get("value", {})

# 👉 하드코딩된 kubejoin host들 (IP 직접 지정)
kubejoin_hosts = {
    "master1": "192.168.0.11",
    "master2": "192.168.0.12"
}

# 공통 SSH 정보
ssh_user = "ubuntu"
ssh_key_path = "~/.ssh/id_rsa"

inventory_path = os.path.join(os.path.dirname(__file__), "hosts.ini")

with open(inventory_path, "w") as f:

    # masters
    if masters:
        f.write("[masters]\n")
        for name, ip in masters.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")

    # workers
    if workers:
        f.write("[workers]\n")
        for name, ip in workers.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")

    # 공통 그룹: frontend/backend/webserver/dbserver
    shared_groups = ["frontend", "backend", "webserver", "dbserver"]
    all_vms = {**masters, **workers}
    for group in shared_groups:
        f.write(f"[{group}]\n")
        for name, ip in all_vms.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")

    # kubejoin 그룹 (IP 직접 지정)
    if kubejoin_hosts:
        f.write("[kubejoin]\n")
        for name, ip in kubejoin_hosts.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")
