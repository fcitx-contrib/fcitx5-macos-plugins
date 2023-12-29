set -e
. ./common.sh lua $1

# Turning on dlopen produces wrong config.h,
# and even fixed it will hard-code lua dylib path in code.
f5m_configure -DENABLE_TEST=OFF -DUSE_DLOPEN=OFF
f5m_build
f5m_install
f5m_make_tarball
