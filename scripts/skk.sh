set -e

. ./common.sh skk $1

# Use PkgConfig::LibSKK
sed -i '' 's/find_package(LibSKK REQUIRED)/pkg_check_modules(LibSKK REQUIRED IMPORTED_TARGET "libskk" REQUIRED)/' CMakeLists.txt
sed -i '' 's/LibSKK::LibSKK/PkgConfig::LibSKK/' src/CMakeLists.txt

# Patch to support $XDG_DATA_DIR
git checkout src/skk.cpp
git apply ../patches/skk-XDG_DATA_DIR.patch

# Download the default dict
dict_dir=$DESTDIR$INSTALL_PREFIX/share/skk-dict
mkdir -p $dict_dir
cd $dict_dir
wget -nc https://skk-dev.github.io/dict/SKK-JISYO.L.gz
gunzip -f SKK-JISYO.L.gz
mv SKK-JISYO.L $dict_dir/SKK-JISYO.L
cd -

# Build fcitx5-skk
install_deps libxkbcommon pcre2 glib libgee libskk json-glib
f5m_configure -DENABLE_QT=OFF
f5m_build
f5m_install

# Write the new dictionary list
cat > $DESTDIR$INSTALL_PREFIX/share/fcitx5/skk/dictionary_list <<EOF
type=file,file=\$FCITX_CONFIG_DIR/skk/user.dict,mode=readwrite
type=file,file=\$XDG_DATA_DIR/skk-dict/SKK-JISYO.L,mode=readonly
EOF

f5m_make_tarball
