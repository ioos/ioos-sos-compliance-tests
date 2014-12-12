#!/bin/bash
command -v git >/dev/null 2>&1 || { echo "git command must be installed" >&2; exit 1; }
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$DIR"/..
if [[ $# -ne 1 ]]; then
  echo "Provide release tag as argument"
  exit 1
fi
TAG=$1

cd $ROOT
rm -rf target
mkdir target
git archive -o target/ioos-sos-compliance-tests-$TAG.zip --prefix=ioos-sos-compliance-tests-$TAG/ $TAG
