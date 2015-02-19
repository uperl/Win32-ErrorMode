use strict;
use warnings;
use Test::More tests => 1;
use Win32::ErrorMode qw( :all );

my $mode = GetErrorMode();

note "mode = $mode\n";

like $mode, qr{^[0-9]+$}, "mode looks like an integer";
