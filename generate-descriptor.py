import json
import os

cwd = os.getcwd()
plugin = cwd.split("/")[-3] # /path/to/rime/tmp/fcitx5
files: list[str] = []

for dirpath, _, filenames in os.walk(os.getcwd()):
    for filename in filenames:
        files.append(f"{dirpath[len(cwd) + 1:]}/{filename}")

os.makedirs("plugin", exist_ok=True)
with open(f"plugin/{plugin}.json", "w") as f:
    json.dump({
        "files": files
    }, f)
