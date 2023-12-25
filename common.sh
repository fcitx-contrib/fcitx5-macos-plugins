name=$1
export DESTDIR=`pwd`/build/$name
cd fcitx5-$name

cbr() {
  cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_ROOT_PATH="/Library/Input Methods/Fcitx5.app/Contents" "$@"
}

cb() {
  cmake --build build
}

ci() {
  cmake --install build
}

tbz() {
  cd $DESTDIR/..
  tar cjvf $name-x86_64.tar.bz2 -C $name/usr/local lib share
}
