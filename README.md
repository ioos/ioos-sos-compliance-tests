# ioos-sos-compliance-tests

A set of CTL ([compliance test language](http://portal.opengeospatial.org/files/?artifact_id=33085)) files and utility scripts to test IOOS SOS implementations.

Still very much a work in progress.

See [list of covered tests](covered_tests.txt) for implementation converage.
See [full test list](https://github.com/abirger/documentation-in-markdown/blob/master/testing/sos_test_list_github_notoc_summary.md) for the full list of IOOS SOS tests.

## Running

* Copy [bin/example-test-config.xml](bin/example-test-config.xml) and edit for your SOS deployment.
* Run [bin/install_teamengine.sh](bin/install_teamengine.sh) (once) to install a local teamengine instance.
* Run [bin/run_tests.sh](bin/run_tests.sh) with your test config XML file as the only argument to test your instance.
