set -e

. ./common.sh hallelujah $1

install_deps marisa fmt json-c
f5m_configure -DENABLE_TEST=OFF
f5m_build
f5m_install
f5m_make_tarball hallelujah
