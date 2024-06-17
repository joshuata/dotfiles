#!/usr/bin/python3

from urllib.request import urlopen
import json
from pathlib import Path

response = urlopen('https://api.github.com/meta')

# Convert bytes to string type and string type to dict
json_obj = json.loads(response.read().decode('utf-8'))
keys = json_obj["ssh_keys"]
new_host_lines = list(map(lambda key: f"github.com {key}\n", keys))

hosts_file = Path.home() / ".ssh" / "known_hosts"
tmp_hosts_file = Path.home() / ".ssh" / "known_hosts.tmp"

if hosts_file.exists():
    with hosts_file.open(mode="r") as infile:
        old_host_lines = infile.readlines()
else:
    old_host_lines = []

with tmp_hosts_file.open("w") as outfile:
    outfile.writelines(new_host_lines)
    for line in old_host_lines:
        if not line.startswith("github.com"):
            outfile.write(line)

tmp_hosts_file.rename(hosts_file)
