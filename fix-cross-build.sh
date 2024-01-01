set -e
if [[ -z "$CI" ]]; then
  exit 1
fi

broken_packages=(
  chinese-addons
  rime
)

ROOT=`pwd`

for package in "${broken_packages[@]}"; do
  tmp_dir=/tmp/$package
  native_pkg=$package-x86_64.tar.bz2
  cross_pkg=$package-arm64.tar.bz2
  mkdir $tmp_dir
  tar xjvf $native_pkg -C $tmp_dir
  tar xjvf $cross_pkg -C $tmp_dir
  cd $tmp_dir
  tar cjvf $ROOT/$cross_pkg *
  cd $ROOT
done
