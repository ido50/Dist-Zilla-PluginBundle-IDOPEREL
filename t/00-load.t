#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Dist::Zilla::PluginBundle::IDOPEREL' ) || print "Bail out!
";
}

diag( "Testing Dist::Zilla::PluginBundle::IDOPEREL $Dist::Zilla::PluginBundle::IDOPEREL::VERSION, Perl $], $^X" );
