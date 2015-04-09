# CDK-51DegreesFilter

This module creates an Apache handler that associates a user agent with a set of device properties using the FiftyOneDegrees::PatternV3 device detection module.


## INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make test
   make install

## DEPENDENCIES

The major dependencies is the FiftyOneDegrees::PatternV3 module available from http://51degrees.com/.  

## CONFIGURATION

To configure the handler, add these settings to your httpd.conf file and restart your apache server.

PerlSwitches -I/opt/51Degrees/lib
PerlTransHandler +CDK::51DegreesFilter
PerlSetEnv DeviceRepository /path/to/your/51Degrees-Lite.dat
PerlSetEnv DevicePropertyList Id,ScreenPixelsHeight,BatteryCapacity
PerlSetEnv DevicePrefix _51D

## DEFINITIONS

DeviceRepository - the location of your 51 Degrees device repository file
DevicePropertyList - the list of properties that you want to detect. Complete list of properties can be found oat http://51degrees.com/.
DevicePrefix - for each property defined in DevicePropertyList, the handler will create an enviornment variable called ${DevicePrefix}_${DeviceProperty}.  for example, _51D_ID.

Configure the LogFormat to output the properties:

LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %{_51D_ID}e"" combined
