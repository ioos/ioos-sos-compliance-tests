# ioos-sos-compliance-tests

A set of CTL ([compliance test language](http://portal.opengeospatial.org/files/?artifact_id=33085)) files and utility scripts to test IOOS SOS implementations.

Still very much a work in progress.

See [covered\_tests.txt](covered_tests.txt) for a list of implemented tests.
See https://github.com/abirger/documentation-in-markdown/blob/master/testing/sos\_test\_list\_github\_notoc\_summary.md for the full list of IOOS SOS tests.

## Running

* Copy [bin/example-test-config.xml](bin/example-test-config.xml) and edit for your SOS deployment.
* Run [bin/install\_teamengine.sh](bin/install_teamengine.sh) (once) to install a local teamengine instance.
* Run [bin/run\_tests.sh](bin/run_tests.sh) with your test config XML file as the only argument to test your instance.
