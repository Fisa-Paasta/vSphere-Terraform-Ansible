#!/usr/bin/env python3
import json
import subprocess
import os

output = subprocess.check_output(["terraform", "output", "-json"], cwd="../terraform-vsphere")
parsed = json.loads(output)

masters = parsed.get("master_ips", {}).get("value", {})
workers = parsed.get("worker_ips", {}).get("value", {})

inventory_path = os.path.join(os.path.dirname(__file__), "hosts.ini")

with open(inventory_path, "w") as f:
    if masters:
        f.write("[masters]\n")
        for name, ip in masters.items():
            f.write(f"{name} ansible_host={ip}\n")
        f.write("\n")

    if workers:
        f.write("[workers]\n")
        for name, ip in workers.items():
            f.write(f"{name} ansible_host={ip}\n")
        f.write("\n")

    # kubejoin 그룹은 첫 번째 master에만 할당
    if masters:
        first_master = list(masters.keys())[0]
        f.write("[kubejoin]\n")
        f.write(f"{first_master}\n")
        f.write("\n")

    f.write("[all:vars]\n")
    f.write("ansible_user=ubuntu\n")  # 필요 시 사용자 수정
