package Win32::ErrorMode;

use strict;
use warnings;
use base qw( Exporter );
use constant {
  SEM_FAILCRITICALERRORS     => 0x0001,
  SEM_NOGPFAULTERRORBOX      => 0x0002,
  SEM_NOALIGNMENTFAULTEXCEPT => 0x0004,
  SEM_NOOPENFILEERRORBOX     => 0x8000,
};

# ABSTRACT: Set and retrieves the error mode for the current process.
# VERSION

=head1 SYNOPSIS

 use Win32::ErrorMode qw( GetErrorMode SetErrorMode );

=head1 DESCRIPTION

=cut

our @EXPORT_OK = qw(
  GetErrorMode SetErrorMode
  SEM_FAILCRITICALERRORS
  SEM_NOALIGNMENTFAULTEXCEPT
  SEM_NOGPFAULTERRORBOX
  SEM_NOOPENFILEERRORBOX
);
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

require XSLoader;
XSLoader::load('Win32::ErrorMode', $Win32::ErrorMode::VERSION);

=head1 FUNCTIONS

=head2 SetErrorMode

 SetErrorMode($mode);

Controls whether Windows will handle the specified type of serious erros 
or whether the process wil handle them.

C<$mode> can be zero or more of the following values, bitwise or'd 
together:

=over 4

=item SEM_FAILCRITICALERRORS

Do not display the critical error message box.

=item SEM_NOALIGNMENTFAULTEXCEPT

Automatically fix memory alignment faults.

=item SEM_NOGPFAULTERRORBOX

Do not display the windows error reporting dialog.

=item SEM_NOOPENFILEERRORBOX

Do not display a message box when the system fails to find a file.

=back

=head2 GetErrorMode

 my $mode = GetErrorMode();

Retrieves the error mode for the current process.

=head1 SEE ALSO

L<Win32API::File> includes an interface to C<SetErrorMode>, but not
C<GetErrorMode> and a whole lot else.  The inteface to C<SetErrorMode>
is not well documented there, but is usable.

=cut

1;
