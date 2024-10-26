set -e
mkdir -p fcitx5-mozc
. ./common.sh mozc $1

mkdir -p $DESTDIR$INSTALL_PREFIX/{lib/{fcitx5,mozc},share/fcitx5/{addon,inputmethod}}
for file in libmozc-$ARCH.so mozc_server-$ARCH mozc-addon.conf mozc.conf; do
  [[ -f $CACHE_DIR/$file ]] || wget -P $CACHE_DIR https://github.com/fcitx-contrib/mozc-cmake/releases/download/latest/$file
done
cp $CACHE_DIR/libmozc-$ARCH.so $DESTDIR$INSTALL_PREFIX/lib/fcitx5/libmozc.so
cp $CACHE_DIR/mozc_server-$ARCH $DESTDIR$INSTALL_PREFIX/lib/mozc/mozc_server
chmod +x $DESTDIR$INSTALL_PREFIX/lib/mozc/mozc_server
cp $CACHE_DIR/mozc-addon.conf $DESTDIR$INSTALL_PREFIX/share/fcitx5/addon/mozc.conf
cp $CACHE_DIR/mozc.conf $DESTDIR$INSTALL_PREFIX/share/fcitx5/inputmethod/mozc.conf

f5m_split_data
f5m_make_tarball mozc
