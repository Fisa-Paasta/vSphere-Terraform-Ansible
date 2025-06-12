#!/usr/bin/env python3
import json
import subprocess
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
terraform_dir = os.path.abspath(os.path.join(script_dir, "../../terraform-vsphere"))

output = subprocess.check_output(["terraform", "output", "-json"], cwd=terraform_dir)
parsed = json.loads(output)

masters = parsed.get("master_ips", {}).get("value", {})
workers = parsed.get("worker_ips", {}).get("value", {})

# kubejoin은 수동으로 설정한 경우
kubejoin_hosts = {
    "master1": "10.8.0.11",
    "master2": "10.8.0.12",
    "master3": "10.8.0.13"
}

ssh_user = "ubuntu"
ssh_key_path = "~/.ssh/id_rsa"
inventory_path = os.path.join(os.path.dirname(__file__), "hosts.ini")

with open(inventory_path, "w") as f:

    # [masters]
    if masters:
        f.write("[masters]\n")
        for name, ip in masters.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")

    # [workers]
    if workers:
        f.write("[workers]\n")
        for name, ip in workers.items():
            if name not in masters:  # 마스터에 포함된 노드는 제외
                f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")

    # 공통 그룹
    shared_groups = ["frontend", "backend", "webserver", "dbserver"]
    all_unique_vms = {**masters, **workers}
    for group in shared_groups:
        f.write(f"[{group}]\n")
        for name, ip in all_unique_vms.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")

    # kubejoin 그룹
    if kubejoin_hosts:
        f.write("[kubejoin]\n")
        for name, ip in kubejoin_hosts.items():
            f.write(f"{name} ansible_host={ip} ansible_user={ssh_user} ansible_ssh_private_key_file={ssh_key_path}\n")
        f.write("\n")
