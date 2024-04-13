set -e

. ./common.sh unikey $1

f5m_configure -DENABLE_QT=OFF -DENABLE_TEST=OFF
f5m_build
f5m_install
f5m_make_tarball unikey
