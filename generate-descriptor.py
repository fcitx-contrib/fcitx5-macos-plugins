import json
import os
import sys

input_methods = sys.argv[1:]

cwd = os.getcwd()
plugin = cwd.split("/")[-3] # /path/to/rime/tmp/fcitx5
files: list[str] = []

for dirpath, _, filenames in os.walk(os.getcwd()):
    for filename in filenames:
        files.append(f"{dirpath[len(cwd) + 1:]}/{filename}")

os.makedirs("plugin", exist_ok=True)
with open(f"plugin/{plugin}.json", "w") as f:
    descriptor = {
        "files": files
    }
    if input_methods:
        descriptor["input_methods"] = input_methods
    json.dump(descriptor, f)
