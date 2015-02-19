use strict;
use warnings;
use Test::More;
use Win32::ErrorMode qw( :all );

plan skip_all => 'test requires working GetThreadErrorMode and SetThreadErrorMode'
  unless Win32::ErrorMode::_has_thread();
plan tests => 2;

my $mode = GetThreadErrorMode();

note "mode = $mode\n";

like $mode, qr{^[0-9]+$}, "mode looks like an integer";

SetThreadErrorMode(0);

is GetThreadErrorMode(), 0, "SetThreadErrorMode() updates ThreadErrorMode";
