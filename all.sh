#!/bin/bash

set -e

all_plugins=(
  skk
  lua
  hallelujah
  chinese-addons # Optional dependency: lua
  thai
  rime
  unikey
)

for plugin in "${all_plugins[@]}"; do
  scripts/$plugin.sh $1
done
