# ioos-sos-compliance-tests

A set of CTL ([compliance test language](http://portal.opengeospatial.org/files/?artifact_id=33085)) files and utility scripts to test IOOS SOS implementations.

Still very much a work in progress. All GetCapabilities tests have been implemented. DescribeSensor and GetObservation still need a lot of work.

See [list of covered tests](covered_tests.txt) for implementation converage.

See [full test list](https://github.com/ioos/sos-guidelines/blob/master/doc/testing/sos_test_list_github_notoc_summary.md) for the full list of IOOS SOS tests.

## Running

* Copy [bin/example-test-config.xml](bin/example-test-config.xml) and edit for your SOS deployment.
* Run [bin/install_teamengine.sh](bin/install_teamengine.sh) (once) to install a local teamengine instance.
* Run [bin/run_tests.sh](bin/run_tests.sh) with the path to your test config XML file as an argument to test your instance.

```
bin/run_tests.sh path/to/your-test-config.xml
```

* Optionally include a regex pattern as a second argument to only run matching tests

```
bin/run_tests.sh path/to/your-test-config.xml ResponseContainsValidOperationsMetadataProperty.8
bin/run_tests.sh path/to/your-test-config.xml "describeSensor*"
```

