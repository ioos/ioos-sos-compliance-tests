# ioos-sos-compliance-tests

A set of CTL ([compliance test language](http://portal.opengeospatial.org/files/?artifact_id=33085)) files and utility scripts to test IOOS SOS implementations.
Uses OGC's [teamengine](https://github.com/opengeospatial/teamengine) to run tests.

Still a work in progress. All GetCapabilities and DescribeSensor tests have been implemented. GetObservation still need a lot of work.

See [list of covered tests](covered_tests.txt) for implementation converage.

See [full test list](https://github.com/ioos/sos-guidelines/blob/master/doc/testing/sos_test_list_github_notoc_summary.md) for the full list of IOOS SOS tests.

## Requirements

Java 7+ is required.

This project is tested on Linux but should also run on Mac OS X. Windows is not directly supported at the moment but it is possible to make it work in two ways:

1. Install a virtualization platform with Linux as a guest OS; Oracle VirtualBox with Linux Mint works perfectly;
2. If the GitHub for Windows is already installed it is possible to run the tests in the Bash environment for Windows:
  * install [MinGW (Minimalist GNU for Windows) with msys](http://sourceforge.net/projects/mingw/);
  * copy the following files from the “C:\MinGW\msys\1.0\bin” folder to the “C:\Program Files (x86)\Git\bin” folder (the real paths depend on where the MinGW and Git for Windows were installed, and may vary):
    - readlink.exe
    - grep.exe  (replace existing file)
    - msys-iconv-2.dll
    - msys-intl-8.dll
  * install the latest Java SE Runtime Environment (JRE for end users) or upgrade it to the version 7+



## Usage

### Download release zip

Download and unzip a release from the [release section](https://github.com/ioos/ioos-sos-compliance-tests/releases).

### Configuration file

Create a configuration file for the target SOS. You'll need to specify the SOS service URL, procedure identifiers for DescribeSensor tests,
and constellations of offerings, procedures, and observed properties for GetObservation tests.

Copy [example-test-config.xml](example-test-config.xml) to a new location and customize for the target SOS.

The example config targets the i52n development continuous integration build.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<config>
  <!-- The service endpoint of the SOS server to be tested -->
  <serviceUrl>http://ioossos.axiomalaska.com/52n-sos-ioos-dev/service</serviceUrl>
  <!-- checkAll="true" to run describeSensor tests on all procedures in the SOS. Otherwise list below -->
  <describeSensor checkAll="false">
    <procedures>
      <procedure>urn:ioos:network:test:all</procedure>
      <procedure>urn:ioos:station:test:0</procedure>
      <procedure>urn:ioos:sensor:test:0:air_temperature</procedure>
      <procedure>urn:ioos:sensor:test:0:sea_water_temperature</procedure>
    </procedures>
  </describeSensor>
  <getObservation>
    <!-- constellations of getObservation request values to use to run tests -->
    <getObservationConstellations>
      <getObservationConstellation>
        <offering>urn:ioos:network:test:all</offering>
        <procedures>
          <procedure>urn:ioos:sensor:test:1:air_temperature</procedure>
        </procedures>
        <observedProperties>
          <observedProperty>http://mmisw.org/ont/cf/parameter/air_temperature</observedProperty>
        </observedProperties>
      </getObservationConstellation>
    </getObservationConstellations>
  </getObservation>
</config>
```

### Run the tests

Run the test initiation script with the config file path as an argument.

```
./run_tests.sh path/to/your-test-config.xml
```

Optionally include a regex pattern as a second argument to only run matching tests

```
./run_tests.sh path/to/your-test-config.xml ResponseContainsValidSRSName.1
./run_tests.sh path/to/your-test-config.xml "describeSensor*"
```

