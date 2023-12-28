set -e
. ./common.sh chinese-addons $1
cd "$ADDON_ROOT"

ARGS=(
    -DENABLE_TEST=OFF
    -DENABLE_GUI=OFF
)

if [[ $ARCH != $(uname -m) ]]; then
    ARGS+=("-DENABLE_DATA=OFF")
fi

f5m_configure "${ARGS[@]}"
f5m_build
f5m_install
f5m_make_tarball
