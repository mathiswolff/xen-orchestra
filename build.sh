#!/bin/sh
set -e

nobanner=0

while getopts "b" opt; do
  case "$opt" in
  b)
    nobanner=1
  ;;
  '?')
    exit 64
  ;;
  esac
done

# shift already parsed options
[ $OPTIND -gt 1 ] && shift $((OPTIND - 1))

export DEBEMAIL="root@localhost"

if [ -n "$XO_REPO" ]; then
  xorepo="$XO_REPO"
else
  xorepo="https://github.com/vatesfr/xen-orchestra"
fi

case "$1" in
  refs/tags/*)
    version="$(echo "$1" | sed -e 's,^refs/tags/,,')"
  ;;
  *)
    version="$1"
  ;;
esac

[ -n "$version" ] || exit 1

pkg="xo-server"

scriptdir="$(dirname "$(readlink -f "$0")")"

gitref="$(awk -F= "{ if(\$1 ==\"$version\"){ print \$2; exit; } }" releases.txt)"
[ -n "$gitref" ] || { echo "ERROR: gitref for version $version not found"; exit 1; }

debversion="${version}-1"
if [ $nobanner -ge 1 ]; then
  debversion="${debversion}+nobanner"
fi

srcdir="xo-server-${version}"
srcorig="xo-server_${version}.orig.tar.xz"

mkdir build
cd build

echo "VERSION=${version}" >.build.env
echo "DEBVERSION=${debversion}" >>.build.env
echo "GITREF=${gitref}" >>.build.env

# check out XO git
mkdir "$srcdir"
cd "$srcdir"
git init
git remote add origin "$xorepo"
git fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin "$gitref"
git checkout --progress --force -B master "$gitref"
git remote remove origin

# create source tar
tar -C .. -cJf "$scriptdir/build/$srcorig" "$srcdir/"

# XXX
#sed -i -e 's,github:,https://github.com/,' "$srcdir"/packages/*/package.json

[ -e debian ] && exit 1
cp -a "$scriptdir/debian" .

if [ $nobanner -ge 1 ]; then
  sed -e 's,RelaxCommunityDisclaimers\.patch,NoCommunityDisclaimers.patch,' -i debian/patches/series
else
  rm -f "debian/patches/NoCommunityDisclaimers.patch"
fi

rm -f debian/changelog
dch --preserve --create -v "${debversion}" --distribution stable --package "$pkg" "Upstream Release"

dpkg-buildpackage -S --no-sign
dpkg-buildpackage -b --no-sign

exit 0
