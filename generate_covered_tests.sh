#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
grep -hoPR '(?<=<ctl:test name=").*\:IOOS-SOS.*(?=")' $DIR/m1.0 | uniq | sort > $DIR/covered_tests.txt
