set -e
. ./common.sh lua $1

cd "$ADDON_ROOT"
f5m_configure -DENABLE_TEST=OFF -DUSE_DLOPEN=OFF
f5m_build
f5m_install
f5m_make_tarball
