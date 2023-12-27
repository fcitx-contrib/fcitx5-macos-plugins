set -e
. ./common.sh chinese-addons $1

# Build dependency: libime
cd "$ROOT/libime"
f5m_configure
f5m_build
f5m_install

# Build fcitx5-chinese-addons
cd "$PLUGIN_ROOT"
sedi 's/add_subdirectory.tools.//' CMakeLists.txt  # HACK: Disable tools
f5m_configure -DENABLE_TEST=OFF \
              -DENABLE_GUI=OFF \
              -DLibIMECore_DIR=$PLUGIN_INSTALL_PREFIX/lib/cmake/LibIMECore/ \
              -DLibIMEPinyin_DIR=$PLUGIN_INSTALL_PREFIX/lib/cmake/LibIMEPinyin/ \
              -DLibIMETable_DIR=$PLUGIN_INSTALL_PREFIX/lib/cmake/LibIMETable/
f5m_build
f5m_install

# Output
f5m_make_tarball

# Restore original file contents to make git silent
cd "$PLUGIN_ROOT"
git checkout CMakeLists.txt
