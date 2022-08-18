#!/usr/bin/python3

from urllib.request import urlopen
import json
from pathlib import Path

response = urlopen('https://api.github.com/meta')

# Convert bytes to string type and string type to dict
json_obj = json.loads(response.read().decode('utf-8'))
keys = json_obj["ssh_keys"]
host_lines = list(map(lambda key: "github.com " + key +"\n", keys))

hosts_file = Path.home() / ".ssh" / "known_hosts"
with hosts_file.open(mode='a') as outfile:
    outfile.writelines(host_lines)
