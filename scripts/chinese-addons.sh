set -e
. ./common.sh chinese-addons $1

ARGS=(
  -DENABLE_TEST=OFF
  -DENABLE_GUI=OFF
)

if [[ $ARCH != $(uname -m) ]]; then
  ARGS+=("-DENABLE_DATA=OFF")
fi

install_deps libime
f5m_configure "${ARGS[@]}"
f5m_build
f5m_install libime
f5m_make_tarball
