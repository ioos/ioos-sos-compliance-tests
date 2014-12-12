#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT=$DIR/..
grep -hoIPR '(?<=<ctl:test name=").*\:IOOS-SOS.*(?=")' $ROOT/m1.0 | uniq | sort > $ROOT/covered_tests.txt
