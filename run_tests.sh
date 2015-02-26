#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIGFILE=$1
TESTS=$2
CTLDIR=$DIR/m1.0/ctl
export TE_BASE=$DIR/.te_base

[[ ! -z "$CONFIGFILE" ]] || { echo "Must provide config file path as argument" >&2; exit 1; }
[[ "$CONFIGFILE" == "/*" ]] || CONFIGFILE=`readlink -f "$CONFIGFILE"`
[[ -f "$CONFIGFILE" ]] || { echo "Config file $CONFIGFILE doesn't exist" >&2; exit 1; }
[[ -d "$CTLDIR" ]] || { echo "CTL directory $CTLDIR not found" >&2; exit 1; }

if [[ ! -z $TESTS ]]; then
  TESTSPARAM=@tests="$TESTS"
fi

if [[ -d $TE_BASE ]]; then
  rm -rf $TE_BASE
fi

$DIR/teamengine/bin/unix/test.sh -source="$CTLDIR" @configFile="$CONFIGFILE" @rootDir="$DIR" $TESTSPARAM | GREP_COLOR='1;31' egrep --color 'FAIL|Failed|$'
