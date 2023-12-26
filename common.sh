name=$1
export DESTDIR=`pwd`/build/$name
cd fcitx5-$name

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

cbr() {
  # Install plugins to /usr/local for both arm and x86 to ease fcitx5 search
  PKG_CONFIG_PATH=$HOMEBREW_PREFIX/lib/pkgconfig cmake -B build -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_ROOT_PATH="/Library/Input Methods/Fcitx5.app/Contents;$HOMEBREW_PREFIX" \
    -DCMAKE_OSX_ARCHITECTURES=$ARCH "$@"
}

cb() {
  cmake --build build
}

ci() {
  cmake --install build
}

tbz() {
  cd $DESTDIR/..
  tar cjvf $name-$ARCH.tar.bz2 -C $name/usr/local lib share
}
