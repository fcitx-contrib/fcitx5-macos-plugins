set -e

. ./common.sh skk $1

# Use PkgConfig::LibSKK
sed -i '' 's/find_package(LibSKK REQUIRED)/pkg_check_modules(LibSKK REQUIRED IMPORTED_TARGET "libskk" REQUIRED)/' CMakeLists.txt
sed -i '' 's/LibSKK::LibSKK/PkgConfig::LibSKK/' src/CMakeLists.txt

# Patch to load data files from ~/Library/fcitx5
git checkout src/skk.cpp
git apply ../patches/skk.patch

# Build fcitx5-skk
install_deps libxkbcommon pcre2 glib libgee libskk json-glib
f5m_configure -DENABLE_QT=OFF
f5m_build
f5m_install

# Install libskk data files to ~/Library/fcitx5/share/libskk
rm -rf $DESTDIR$INSTALL_PREFIX/share/libskk
mkdir -p $DESTDIR$INSTALL_PREFIX/share/libskk
mv /tmp/fcitx5/share/libskk/rules $DESTDIR$INSTALL_PREFIX/share/libskk

# Install the default dict to ~/Library/fcitx5/share/skk-dict
dict_dir=$DESTDIR$INSTALL_PREFIX/share/skk-dict
mkdir -p $dict_dir
cd $dict_dir
wget -nc https://skk-dev.github.io/dict/SKK-JISYO.L.gz
gunzip -f SKK-JISYO.L.gz
mv SKK-JISYO.L $dict_dir/SKK-JISYO.L
cd -

# Write the new dictionary list
cat > $DESTDIR$INSTALL_PREFIX/share/fcitx5/skk/dictionary_list <<EOF
type=file,file=\$FCITX_CONFIG_DIR/skk/user.dict,mode=readwrite
type=file,file=\$XDG_DATA_DIR/skk-dict/SKK-JISYO.L,mode=readonly
EOF

f5m_make_tarball skk
