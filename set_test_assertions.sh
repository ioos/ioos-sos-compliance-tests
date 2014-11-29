#!/bin/bash
command -v xmlstarlet >/dev/null 2>&1 || { echo "xmlstarlet is required but not installed (aptitude install -y xmlstarlet)" >&2; exit 1; }
cd $(dirname $0)

rm -rf tmp
mkdir tmp
wget -q -O tmp/tests.md https://raw.githubusercontent.com/ioos/sos-guidelines/master/doc/testing/sos_test_list_github_notoc_summary.md
grep "getCapabilities:IOOS-SOS.GetCapabilities" tmp/tests.md > tmp/getCapabilities.txt
grep "describeSensor:IOOS-SOS.DescribeSensor" tmp/tests.md > tmp/describeSensor.txt
grep "getObservation:IOOS-SOS.GetObservation" tmp/tests.md > tmp/getObservation.txt
sed -i 's/\*//g' tmp/*.txt
sed -i 's/^|//g' tmp/*.txt
sed -i 's/|[^|]*|$//g' tmp/*.txt
sed -i 's/[“”’‘]/"/g' tmp/*.txt 
sed -i 's/\(@.*\)#"/\1="/g' tmp/*.txt
sed -i 's/\\[<>]//g' tmp/*.txt
sed -i 's/ \(.*\)|/\1|/g' tmp/*.txt
sed -i 's/ \(.*\)|/\1|/g' tmp/*.txt

for f in tmp/*.txt; do
  TARGET_FILE=m1.0/ctl/`echo $f | sed -e 's/^tmp\///' -e 's/\.txt$/\.xml/'`
  [[ -e "$TARGET_FILE" ]] || { echo "$TARGET_FILE" doesn\'t exist, skipping.; continue; }
  echo "Processing $TARGET_FILE"
  while read t; do
    IFS='|' read -a array <<< "$t"
    if grep -q "${array[0]}" "$TARGET_FILE"; then
      echo "Setting assertion for ${array[0]}"
      xmlstarlet ed --inplace --update "/ctl:package/ctl:test[@name=\"${array[0]}\"]/ctl:assertion" -v "${array[1]}" "$TARGET_FILE"
      #fix namespace spacing
      sed -i 's/ xmlns/\n  xmlns/g' "$TARGET_FILE"
    fi
  done < $f
done
