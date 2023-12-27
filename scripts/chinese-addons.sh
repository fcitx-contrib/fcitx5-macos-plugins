set -e
. ./common.sh chinese-addons $1

# Fix cross compile
if [[ $ARCH != x86_64 ]]; then
    ( cd "$ROOT/libime/data" && sed -i '' "s|COMMAND LibIME::|COMMAND libime_|" CMakeLists.txt )
    ( cd "$ADDON_ROOT/im/pinyin" && sed -i '' "s|COMMAND LibIME::|COMMAND libime_|" CMakeLists.txt )
fi

############################
# Build dependency: libime #
############################
cd "$ROOT/libime"

f5m_configure -DENABLE_TEST=OFF
f5m_build
f5m_install

###############################
# Build fcitx5-chinese-addons #
###############################
cd "$ADDON_ROOT"
sed -i '' 's/add_subdirectory.tools.//' CMakeLists.txt  # HACK: Disable tools
f5m_configure -DENABLE_TEST=OFF \
              -DENABLE_GUI=OFF \
              -DLibIMECore_DIR=$ADDON_INSTALL_PREFIX/lib/cmake/LibIMECore/ \
              -DLibIMEPinyin_DIR=$ADDON_INSTALL_PREFIX/lib/cmake/LibIMEPinyin/ \
              -DLibIMETable_DIR=$ADDON_INSTALL_PREFIX/lib/cmake/LibIMETable/ \
              -DCMAKE_PREFIX_PATH=$ADDON_INSTALL_PREFIX/../lua/
f5m_build
f5m_install
git checkout CMakeLists.txt

##########
# Output #
##########
f5m_make_tarball
