use strict;
use warnings;
use Test::More tests => 2;
use Win32::ErrorMode qw( :all );

my $mode = GetErrorMode();

note "mode = $mode\n";

like $mode, qr{^[0-9]+$}, "mode looks like an integer";

SetErrorMode(0);

is GetErrorMode(), 0, "SetErrorMode() updates ErrorMode";
