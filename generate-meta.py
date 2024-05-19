import json
import os
import subprocess

def getArch():
    result = subprocess.run(["uname", "-m"], stdout=subprocess.PIPE, text=True)
    return result.stdout.strip()


arch = getArch()
plugins = []

for script in os.listdir("scripts"):
    plugin = script.split(".")[0]
    descriptor = f"build/{plugin}/tmp/fcitx5/plugin/{plugin}.json"
    with open(descriptor, "r") as f:
        version = json.load(f)["version"]
    plugins.append({
        "name": plugin,
        "version": version
    })

with open(f"meta-{arch}.json", "w") as f:
    json.dump({
        "plugins": plugins,
    }, f)
