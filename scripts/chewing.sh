set -e

. ./common.sh chewing $1

install_deps libchewing
f5m_configure
f5m_build
f5m_install libchewing
f5m_split_data
f5m_make_tarball chewing
