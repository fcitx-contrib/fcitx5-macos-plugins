set -e
. ./common.sh chinese-addons $1

git reset --hard
git apply ../patches/chinese-addons.patch
install_deps libime marisa opencc zstd boost

export LDFLAGS="-L$INSTALL_PREFIX/lib -lmarisa"

ARGS=(
  -DCMAKE_CXX_FLAGS="-I$INSTALL_PREFIX/include/Fcitx5/Module/fcitx-module/luaaddonloader"
  -DENABLE_TEST=OFF
  -DENABLE_GUI=OFF
)

if [[ $ARCH != $(uname -m) ]]; then
  ARGS+=("-DENABLE_DATA=OFF")
fi

f5m_configure "${ARGS[@]}"
f5m_build
f5m_install libime opencc
# Install zh_CN.lm and zh_CN.lm.predict which are not in share
tar xjvf $CACHE_DIR/libime-$ARCH.tar.bz2 -C $DESTDIR$INSTALL_PREFIX lib/libime
f5m_make_tarball
