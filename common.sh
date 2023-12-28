name=$1

ROOT=`pwd`
ADDON_ROOT=$ROOT/fcitx5-$name
DESTDIR=$ROOT/build/$name

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
  PKG_CONFIG_PATH=$HOMEBREW_PREFIX/lib/pkgconfig cmake -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_ROOT_PATH="/Library/Input Methods/Fcitx5.app/Contents;$HOMEBREW_PREFIX" \
    -DCMAKE_OSX_ARCHITECTURES=$ARCH "$@"
}

f5m_build() {
  cmake --build build
}

f5m_install() {
  cmake --install build # install for other plugins
  DESTDIR=$DESTDIR cmake --install build # install for package
}

f5m_make_tarball() {
  cd $DESTDIR/usr/local
  tar cjvf ../../../$name-$ARCH.tar.bz2 *
}

set -x
cd $ADDON_ROOT
