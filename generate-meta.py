import json
import os
import subprocess

def getArch():
    result = subprocess.run(["uname", "-m"], stdout=subprocess.PIPE, text=True)
    return result.stdout.strip()


arch = getArch()
plugins = []

for plugin in os.listdir("build"):
    if plugin.endswith(".tar.bz2"):
        continue
    descriptor = f"build/{plugin}/tmp/data/plugin/{plugin}.json"
    with open(descriptor, "r") as f:
        j = json.load(f)
        version = j.get("version")
        data_version = j["data_version"]
    plugins.append({
        "name": plugin,
        "data_version": data_version
    })
    if version:
        plugins[-1]["version"] = version

with open(f"meta-{arch}.json", "w") as f:
    json.dump({
        "plugins": plugins,
    }, f)
