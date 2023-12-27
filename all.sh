#!/bin/bash

set -e

all_plugins=(
    hallelujah
    chinese-addons
)

for plugin in "${all_plugins[@]}"
do
    scripts/$plugin.sh $1
done
