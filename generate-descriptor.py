import json
import os
import subprocess
import sys

input_methods = sys.argv[1:]

cwd = os.getcwd()
plugin = cwd.split("/")[-3] # /path/to/rime/tmp/fcitx5
files: list[str] = []

for dirpath, _, filenames in os.walk(cwd):
    if dirpath == "plugin":
        continue
    for filename in filenames:
        files.append(f"{dirpath[len(cwd) + 1:]}/{filename}")


def getVersion():
    # XXX: it causes unnecessary update when the plugin is not changed
    result = subprocess.run(["git", "rev-parse", "HEAD"], stdout=subprocess.PIPE, text=True)
    return result.stdout.strip()


version = getVersion()

os.makedirs("plugin", exist_ok=True)
with open(f"plugin/{plugin}.json", "w") as f:
    descriptor = {
        "version": version,
        "files": files
    }
    if input_methods:
        descriptor["input_methods"] = input_methods
    json.dump(descriptor, f)
