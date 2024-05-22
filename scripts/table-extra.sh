set -e
. ./common.sh table-extra $1

install_deps libime

f5m_configure
f5m_build
f5m_install
f5m_make_tarball table-extra
