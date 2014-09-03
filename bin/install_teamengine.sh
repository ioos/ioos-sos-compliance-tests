#!/bin/bash
command -v wget >/dev/null 2>&1 || { echo "wget command must be installed" >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip command must be installed" >&2; exit 1; }
command -v mvn >/dev/null 2>&1 || { echo "mvn command must be installed" >&2; exit 1; }

VERSION=4.0.5
TE_ZIP_PREFIX=tmp/teamengine-$VERSION/teamengine-console/target/teamengine-console-$VERSION
TE_BIN_ZIP=$TE_ZIP_PREFIX-bin.zip

rm -rf tmp
mkdir -p tmp
mkdir -p logs
echo Downloading teamengine version $VERSION
wget -q -O tmp/teamengine_$VERSION.zip https://github.com/opengeospatial/teamengine/archive/$VERSION.zip
echo Extracting teamengine source
unzip -q tmp/teamengine_$VERSION.zip -d tmp
echo Building teamengine
cd tmp/teamengine-$VERSION
mvn clean install > ../../logs/teamengine_${VERSION}_mvn_install.log 2>&1
cd ../..
if [ ! -f $TE_BIN_ZIP ]; then
  echo "Build failed";
  exit 0;
fi
echo Installing teamengine
rm -rf teamengine-*
mkdir teamengine-$VERSION
unzip -q -d teamengine-$VERSION $TE_BIN_ZIP
echo Installation complete, cleaning up
rm -rf tmp
