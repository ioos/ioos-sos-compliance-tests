#!/bin/bash
command -v git >/dev/null 2>&1 || { echo "git command must be installed" >&2; exit 1; }
command -v zip >/dev/null 2>&1 || { echo "zip command must be installed" >&2; exit 1; }
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$DIR"/..
if [[ $# -ne 1 ]]; then
  echo "Provide release tag as argument"
  exit 1
fi
TAG=$1
OUT=ioos-sos-compliance-tests-$TAG
cd $ROOT
rm -rf target
mkdir target
git archive -o target/$OUT.zip --prefix=$OUT/ $TAG

rm -rf tmp
mkdir -p tmp/$OUT
cd tmp
cp -r $ROOT/teamengine $OUT
zip -rq $ROOT/target/$OUT.zip $OUT
cd $ROOT
rm -rf tmp
