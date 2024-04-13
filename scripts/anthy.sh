set -e

. ./common.sh anthy $1

install_deps anthy-unicode

f5m_configure -DENABLE_TEST=OFF
f5m_build
f5m_install
f5m_make_tarball
