set -e
. ./common.sh table-extra $1

install_deps boost libime

f5m_configure
f5m_build
f5m_install

cd $ROOT/build
python $ROOT/package-table-extra.py

# generate-meta.py will enumerate build/
rm -r $ROOT/build/table-extra
