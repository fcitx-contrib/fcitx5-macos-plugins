set -e
. ./common.sh rime $1

install_deps librime

# Install schemas
cd $ROOT/fcitx5-rime-data
rime_dir=$ROOT/build/rime/usr/local/share/fcitx5/rime
mkdir -p $rime_dir
cp rime-prelude/*.yaml $rime_dir
cp rime-essay/essay.txt $rime_dir
cp rime-luna-pinyin/*.yaml $rime_dir
cp rime-stroke/*.yaml $rime_dir
cp default.yaml $rime_dir
cd -

# Build fcitx5-rime
ARGS=(
  -DRIME_DATA_DIR=/usr/local/share/fcitx5/rime
)

f5m_configure ${ARGS[@]}
f5m_build
f5m_install librime
f5m_make_tarball
