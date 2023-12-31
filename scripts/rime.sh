set -e

. ./common.sh rime $1

ARGS=(
    -DRIME_DATA_DIR=/usr/local/share/fcitx5/rime
)

install_deps librime
f5m_configure ${ARGS[@]}
f5m_build
f5m_install
f5m_make_tarball
