#!/bin/bash

set -e

all_plugins=(
  chewing
  hangul
  sayura
  skk
  lua
  hallelujah
  chinese-addons # Optional dependency: lua
  thai
  rime
  unikey
  anthy
  table-extra
)

for plugin in "${all_plugins[@]}"; do
  scripts/$plugin.sh $1
done
