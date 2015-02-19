# Win32::ErrorMode

Set and retrieves the error mode for the current process.

# SYNOPSIS

    use Win32::ErrorMode qw( GetErrorMode SetErrorMode );

# DESCRIPTION

# FUNCTIONS

## SetErrorMode

    SetErrorMode($mode);

Controls whether Windows will handle the specified type of serious erros 
or whether the process wil handle them.

`$mode` can be zero or more of the following values, bitwise or'd 
together:

- SEM\_FAILCRITICALERRORS

    Do not display the critical error message box.

- SEM\_NOALIGNMENTFAULTEXCEPT

    Automatically fix memory alignment faults.

- SEM\_NOGPFAULTERRORBOX

    Do not display the windows error reporting dialog.

- SEM\_NOOPENFILEERRORBOX

    Do not display a message box when the system fails to find a file.

## GetErrorMode

    my $mode = GetErrorMode();

Retrieves the error mode for the current process.

# SEE ALSO

[Win32API::File](https://metacpan.org/pod/Win32API::File) includes an interface to `SetErrorMode`, but not
`GetErrorMode` and a whole lot else.  The inteface to `SetErrorMode`
is not well documented there, but is usable.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
