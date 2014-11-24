#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIGFILE=$1
TESTS=$2
CTLDIR=$DIR/../m1.0/ctl
[[ ! -z "$CONFIGFILE" ]] || { echo "Must provide config file path as argument" >&2; exit 1; }
[[ "$CONFIGFILE" == "/*" ]] || CONFIGFILE=`readlink -f "$CONFIGFILE"`
[[ -f "$CONFIGFILE" ]] || { echo "Config file $CONFIGFILE doesn't exist" >&2; exit 1; }
[[ -d "$CTLDIR" ]] || { echo "CTL directory $CTLDIR not found" >&2; exit 1; }
[ -d "$DIR"/teamengine-* ] || { echo "teamengine not installed. Run install_teamengine.sh first" >&2; exit 1; }

if [[ ! -z $TESTS ]]; then
  TESTSPARAM=@tests="$TESTS"
fi

$DIR/teamengine-*/bin/unix/test.sh -source="$CTLDIR" @configFile="$CONFIGFILE" $TESTSPARAM | GREP_COLOR='1;31' egrep --color 'FAIL|Failed|$'
