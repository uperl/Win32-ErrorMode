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

 use Win32::ErrorMode qw( :all );
 
 my $error_mode = GetErrorMode();
 SetErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX);
 
 system "program_that_would_normal_produce_an_error_dialog.exe";

If you are using Windows 7 or better:

 use Win32::ErrorMode qw( :all );
 
 # The "Thread" versions are safer if you are using threads,
 # which includes the use of fork() on Windows.
 my $error_mode = GetThreadErrorMode();
 SetThreadErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX);
 
 system "program_that_would_normal_produce_an_error_dialog.exe";

=head1 DESCRIPTION

=cut

our @EXPORT_OK = qw(
  GetErrorMode SetErrorMode
  GetThreadErrorMode SetThreadErrorMode
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

=head2 SetThreadErrorMode

 SetThreadErrorMode($mode);

Same as L</SetErrorMode> above, except it only changes the error mode
on the current thread.  Only available when running under Windows 7 or
newer.

=head2 GetThreadErrorMode

 my $mode = GetThreadErrorMode();

Same as L</GetErrorMode> above, except it only gets the error mode
for the current thread.  Only available when running under Windows 7
or newer.

=head1 CAVEATS

C<GetErrorMode> was introduced in Windows Vista / 2008, but will be
emulated on XP using C<SetErrorMode>, but there may be a race 
condition if you are using threads / forking as the emulation
temporarily sets the error mode.

=head1 SEE ALSO

L<Win32API::File> includes an interface to C<SetErrorMode>, but not
C<GetErrorMode> and a whole lot else.  The inteface to C<SetErrorMode>
is not well documented there, but is usable.

=cut

1;
