set -e

. ./common.sh sayura $1

f5m_configure
f5m_build
f5m_install
f5m_split_data
f5m_make_tarball sayura
