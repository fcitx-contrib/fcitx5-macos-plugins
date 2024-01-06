set -e
. ./common.sh rime $1

# Decided by patched rimeengine.cpp
rime_data_dir=$INSTALL_PREFIX/share/rime-data

git reset --hard
git apply ../patches/rime.patch
install_deps yaml-cpp leveldb marisa opencc glog librime lua

# This value is only used to install fcitx5.yaml
# and not used in rimeengine.cpp after patching
ARGS=(
  -DRIME_DATA_DIR=$rime_data_dir
)

f5m_configure "${ARGS[@]}"
f5m_build
f5m_install

# Install schemas
rime_dir=$DESTDIR$rime_data_dir
cd $ROOT/fcitx5-rime-data
cp rime-prelude/*.yaml $rime_dir
cp rime-essay/essay.txt $rime_dir
cp rime-luna-pinyin/*.yaml $rime_dir
cp rime-stroke/*.yaml $rime_dir
cp default.yaml $rime_dir
cd -

f5m_make_tarball
