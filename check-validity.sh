set -e

has_homebrew_deps=0

for lib in $(find build -name '*.so'); do
  if otool -L $lib | grep /usr/local; then
    otool -L $lib
    has_homebrew_deps=1
  fi
done

exit $has_homebrew_deps
