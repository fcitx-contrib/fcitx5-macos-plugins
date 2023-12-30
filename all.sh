#!/bin/bash

set -e

all_plugins=(
  lua
  hallelujah
  chinese-addons # Optional dependency: lua
  thai
)

for plugin in "${all_plugins[@]}"; do
  scripts/$plugin.sh $1
done
