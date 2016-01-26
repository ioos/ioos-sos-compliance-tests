#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export TE_BASE=$DIR/.te_base
CTLDIR=$DIR/m1.0/ctl

usage() { echo "Usage: $0 -c ./path/to/config.xml [-t tests]" 1>&2; exit 1; }

CONFIGFILE=$1
while getopts "c:t:" opt; do
  case $opt in
    c)
      CONFIGFILE=${OPTARG}
      ;;
    t)
      TESTS=${OPTARG}
      ;;
    *)
      usage
      ;;
  esac
done


[[ ! -z "$CONFIGFILE" ]] || { usage; }
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
