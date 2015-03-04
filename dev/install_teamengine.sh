#!/bin/bash
command -v unzip >/dev/null 2>&1 || { echo "unzip command must be installed" >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "git must be installed" >&2; exit 1; }
command -v mvn >/dev/null 2>&1 || { echo "mvn must be installed" >&2; exit 1; }
command -v dos2unix >/dev/null 2>&1 || { echo "dos2unix must be installed" >&2; exit 1; }

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$DIR"/..
#GIT_REPO=git@github.com:opengeospatial/teamengine.git
#TARGET=master
GIT_REPO=git@github.com:shane-axiom/teamengine.git
#GIT_BRANCH=fix-inherited-failure
GIT_BRANCH=unified
TE_BIN_ZIP=tmp/teamengine/teamengine-console/target/teamengine-console-*-bin.zip
cd "$DIR"

rm -rf tmp
mkdir -p tmp
mkdir -p logs
cd tmp
echo Checking out git repository from $GIT_REPO
git clone --quiet $GIT_REPO
cd teamengine 

echo Checking out $GIT_BRANCH
git checkout --quiet $GIT_BRANCH
if [[ $? -gt 0 ]]; then
  echo Couldn\'t check out $GIT_BRANCH.
  exit 1
fi
GIT_REV=`git rev-parse HEAD`

echo Building teamengine
mvn clean install > $DIR/logs/teamengine_${TARGET}_mvn_install.log 2>&1
cd $DIR
if [ ! -f $TE_BIN_ZIP ]; then
  echo "Build failed";
  exit 0;
fi
echo Installing teamengine
rm -rf $ROOT/teamengine
mkdir $ROOT/teamengine
unzip -q -d $ROOT/teamengine $TE_BIN_ZIP
cat << EOF > $ROOT/teamengine/version
Build time: `date -u +"%Y-%m-%dT%H:%M:%SZ"`
Git repo: $GIT_REPO
Git branch: $GIT_BRANCH
Git commit: $GIT_REV
EOF

echo Fixing newlines
find $ROOT/teamengine -type f -exec dos2unix -q {} +

echo Installation complete, cleaning up
rm -rf tmp
