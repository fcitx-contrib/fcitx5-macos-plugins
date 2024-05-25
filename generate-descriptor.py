import json
import os
import sys
from dirhash import dirhash

input_methods = sys.argv[1:]

cwd = os.getcwd()
data_dir = f"{cwd}/../data"
plugin = cwd.split("/")[-3] # /path/to/rime/tmp/fcitx5
files: list[str] = []

for wd in (cwd, data_dir):
    for dirpath, _, filenames in os.walk(wd):
        if dirpath == f"{wd}/plugin":
            continue
        for filename in filenames:
            files.append(f"{dirpath[len(wd) + 1:]}/{filename}")

try:
    version = dirhash(cwd, "md5", ignore=["plugin"])
except:
    # pure data plugin
    version = None

data_version = dirhash(data_dir, "md5")

os.makedirs("plugin", exist_ok=True)
with open(f"plugin/{plugin}.json", "w") as f:
    descriptor = {
        "data_version": data_version,
        "files": files
    }
    if version:
        descriptor["version"] = version
    if input_methods:
        descriptor["input_methods"] = input_methods
    json.dump(descriptor, f)
