#!/bin/bash
command -v unzip >/dev/null 2>&1 || { echo "unzip command must be installed" >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "git must be installed" >&2; exit 1; }
command -v mvn >/dev/null 2>&1 || { echo "mvn must be installed" >&2; exit 1; }

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#GIT_REPO=git@github.com:opengeospatial/teamengine.git
GIT_REPO=git@github.com:shane-axiom/teamengine.git
TARGET=fix-inherited-failure
TE_BIN_ZIP=tmp/teamengine/teamengine-console/target/teamengine-console-*-bin.zip
cd $DIR

rm -rf tmp
mkdir -p tmp
mkdir -p logs
cd tmp
echo Checking out git repository from $GIT_REPO
git clone --quiet $GIT_REPO
cd teamengine 

echo Checking out $TARGET
git checkout --quiet $TARGET
if [[ $? -gt 0 ]]; then
  echo Couldn\'t check out $TARGET.
  exit 1
fi

echo Building teamengine
mvn clean install > $DIR/logs/teamengine_${TARGET}_mvn_install.log 2>&1
cd $DIR
if [ ! -f $TE_BIN_ZIP ]; then
  echo "Build failed";
  exit 0;
fi
echo Installing teamengine
rm -rf teamengine-*
mkdir teamengine-$TARGET
unzip -q -d teamengine-$TARGET $TE_BIN_ZIP
echo Installation complete, cleaning up
rm -rf tmp
