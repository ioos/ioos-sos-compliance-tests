#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
RESOURCES=$DIR/../resources
rm -rf $RESOURCES/rdf
mkdir -p $RESOURCES/rdf
wget -O $RESOURCES/rdf/cf-parameter.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/cf/parameter"
wget -O $RESOURCES/rdf/ioos-parameter.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/parameter"
wget -O $RESOURCES/rdf/ioos-organization.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/organization"
wget -O $RESOURCES/rdf/ioos-platform.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/platform"
wget -O $RESOURCES/rdf/ioos-sector.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/sector"
