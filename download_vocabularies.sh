#!/bin/bash
rm -rf resources/rdf
mkdir -p resources/rdf
wget -O resources/rdf/cf-parameter.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/cf/parameter"
wget -O resources/rdf/ioos-parameter.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/parameter"
wget -O resources/rdf/ioos-organization.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/organization"
wget -O resources/rdf/ioos-platform.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/platform"
wget -O resources/rdf/ioos-sector.rdf "http://mmisw.org/ont?form=rdf&uri=http://mmisw.org/ont/ioos/sector"
