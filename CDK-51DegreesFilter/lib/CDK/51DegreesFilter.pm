package CDK::51DegreesFilter; 
  use strict; 
  use warnings; 
  use threads;
  use threads::shared;

  use Apache2::Filter (); 
  use Apache2::RequestRec ();
  use Apache2::RequestUtil ();
  use Apache2::Log;
  use Apache2::Const -compile => qw(DECLINED :log);
  use APR::Const -compile => qw(SUCCESS);
  use APR::Table (); 
  use JSON;

  use lib '/opt/51Degrees/lib/';
  use FiftyOneDegrees::PatternV3;

  #
  # Define the global environment
  # 

  use vars qw($VERSION);
  $VERSION= "0.01";

  my $propertyList="none";
  if ($ENV{DevicePropertyList}) {
    $propertyList=$ENV{DevicePropertyList};
  } else {
    print "DevicePropertyList not set.";
    ModPerl::Util::exit();
  }


  my $prefix="_51D";
  if ($ENV{DevicePrefix}) {
    $prefix=$ENV{DevicePrefix};
  }

  my $dataset;
  if ($ENV{DeviceRepository}) {
    $dataset = FiftyOneDegrees::PatternV3::dataSetInitWithPropertyString($ENV{DeviceRepository}, $propertyList);
  }  else {
    print "DeviceRepository not set.";
    ModPerl::Util::exit();
  }

sub handler {
  my $f = shift;  

  my $user_agent=$f->headers_in->{'User-Agent'} || '';
  my $json = FiftyOneDegrees::PatternV3::getMatch($dataset, $user_agent);
  my %properties = %{ decode_json($json) };

  while ( my ($key, $value) = each(%properties) ) {
    my $dkey = uc("${prefix}_${key}");
    $f->subprocess_env($dkey => $value);
  }

  return Apache2::Const::DECLINED;
}

1; 

=head1 NAME

CDK::51DegreesFilter - The module detects the mobile device and passes the 51Degrees capabilities on to the other web application as environment variables
