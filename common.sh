name=$1

export ROOT=`pwd`
export ADDON_ROOT=`pwd`/fcitx5-$name
export ADDON_INSTALL_PREFIX=`pwd`/build/$name

if [[ -z $2 ]]; then
  ARCH=`uname -m`
else
  ARCH=$2
fi

if [[ $ARCH == x86_64 ]]; then
  HOMEBREW_PREFIX=/usr/local
else
  HOMEBREW_PREFIX=/opt/homebrew
fi

f5m_configure() {
  # Install plugins to /usr/local for both arm and x86 to ease fcitx5 search
  PKG_CONFIG_PATH="$HOMEBREW_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH" cmake -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_ROOT_PATH="/Library/Input Methods/Fcitx5.app/Contents;$HOMEBREW_PREFIX" \
    -DCMAKE_OSX_ARCHITECTURES=$ARCH \
    -DCMAKE_INSTALL_PREFIX="$ADDON_INSTALL_PREFIX" \
    "$@"
}

f5m_build() {
  cmake --build build
}

f5m_install() {
  cmake --install build
}

f5m_make_tarball() {
  cd $ADDON_INSTALL_PREFIX/..
  tar cjvf $name-$ARCH.tar.bz2 -C $name lib share
}
