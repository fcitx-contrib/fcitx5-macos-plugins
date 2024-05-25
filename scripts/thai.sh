set -e

. ./common.sh thai $1

install_deps libthai
f5m_configure
f5m_build
f5m_install
f5m_split_data
f5m_make_tarball libthai
