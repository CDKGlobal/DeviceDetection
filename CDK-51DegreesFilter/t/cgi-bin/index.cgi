#!/usr/bin/perl

# this is a helper script to capture all of the device properties set by the handler
# so that the unit test can easily validate handler functionality
#
# device properties are passed back to client via environment variables
# find all of the environment variables that look like /^_51D/
# and add them to a hash, send hash back as JSON response
#
use CGI qw(:standard -no_xhtml -debug);
use JSON;

print header('application/json');

my %properties;

while ( my ($key, $value) = each(%ENV)) {
  if ( $key =~ /^_51D/) {
    $properties{$key} = $value;
  }
}

print encode_json \%properties;
