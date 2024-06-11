set -e

. ./common.sh hangul $1

install_deps libhangul
f5m_configure
f5m_build
f5m_install libhangul
f5m_split_data
f5m_make_tarball hangul
