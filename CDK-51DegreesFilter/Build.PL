use Module::Build;
use ModPerl::MM ();
use Apache::TestMM qw(test clean);
use Apache::TestRunPerl ();
use IO::File;

my $class = Module::Build->subclass(
    class => 'CDK::Builder',
    code => q{
	sub ACTION_test {
	    my $self = shift;
	    $self->do_system('t/TEST -start-httpd');
	    $self->SUPER::ACTION_test();
	    $self->do_system('t/TEST -stop-httpd');
	}
    }
);

my $build = $class->new (
  module_name => 'CDK::51DegreesFilter',
  license => 'perl',
  test_file_exts => [qw(.t)],
  use_tap_harness => 1,
  tap_harness_args => {
    sources => {
      File => {
        extensions => ['.tap', '.txt'],
      },
    },
    formatter_class => 'TAP::Formatter::JUnit',
  },
  build_requires => {
      'Module::Build' => '0.30',
      'TAP::Harness'  => '3.18',
  },
  test_requires => {
      'Apache::Test' => 0,
  },
  requires => {
      'mod_perl2' => 0,
      'FiftyOneDegrees::PatternV3' => 0,
      'JSON' => 0,
      'Apache2::Filter' => 0,
      'Apache2::RequestRec' => 0,
      'Apache2::RequestUtil' => 0,
      'Apache2::Log' => 0,
      'Apache2::Const' => 0,
      'APR::Table' => 0
  }
);

Apache::TestMM::filter_args();
Apache::TestRunPerl->generate_script();

$build->create_build_script;
