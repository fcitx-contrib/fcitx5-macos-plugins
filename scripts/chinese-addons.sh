set -e
. ./common.sh chinese-addons $1
cd "$ADDON_ROOT"


ARGS=(
    -DENABLE_TEST=OFF
    -DENABLE_GUI=OFF
)


# HACK: Fix cross compile
# Use prebuilt libime_* tools instead of generated ones
if [[ $ARCH != `uname -m` ]]; then
    ( cd "$ADDON_ROOT/im/pinyin" && sed -i '' "s|COMMAND LibIME::|COMMAND /usr/local/bin/libime_|" CMakeLists.txt )
fi


# HACK: Disable tools
sed -i '' 's/add_subdirectory.tools.//' CMakeLists.txt


f5m_configure "${ARGS[@]}"
f5m_build
f5m_install
f5m_make_tarball
