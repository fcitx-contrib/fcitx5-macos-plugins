set -e

. ./common.sh hallelujah $1

cd $ADDON_ROOT
f5m_configure -D ENABLE_TEST=OFF
f5m_build
f5m_install
f5m_make_tarball
