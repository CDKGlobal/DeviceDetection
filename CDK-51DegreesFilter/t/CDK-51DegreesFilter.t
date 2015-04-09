use strict;
use warnings FATAL => 'all';

use Apache::TestTrace;
use Apache::Test qw(plan ok have_lwp);
use Apache::TestRequest qw(GET);
use Apache::TestUtil qw(t_cmp);
use Apache2::Const qw(HTTP_OK);

use JSON;

plan tests => 6, have_lwp;

detect_device('','15364-5690-17190-18092');
detect_device('unknown', '15364-5690-17190-18092');
detect_device(
 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36",
  "15364-18110-25377-18092");

sub detect_device {
  my ($user_agent, $device_id) = @_;

  Apache::TestRequest::user_agent(
    reset => 1,
    agent => $user_agent
  );

  my $response = GET '/cgi-bin/index.cgi';
  my $json = decode_json $response->content;

  debug "response", $response;
  
  ok defined($json->{_51D_ID}) eq 1;
  ok $json->{_51D_ID} eq $device_id;
}
