set -e
. ./common.sh hallelujah $1
cbr -D ENABLE_TEST=OFF
cb
ci
tbz
