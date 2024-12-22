# Win32::ErrorMode ![static](https://github.com/plicease/Win32-ErrorMode/workflows/static/badge.svg) ![windows](https://github.com/plicease/Win32-ErrorMode/workflows/windows/badge.svg) ![msys2-mingw](https://github.com/plicease/Win32-ErrorMode/workflows/msys2-mingw/badge.svg)

Set and retrieves the error mode for the current process.

# SYNOPSIS

```perl
use Win32::ErrorMode qw( :all );

my $error_mode = GetErrorMode();
SetErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX);

system "program_that_would_normal_produce_an_error_dialog.exe";
```

Using the thread interface (preferred):

```perl
use Win32::ErrorMode qw( :all );

# The "Thread" versions are safer if you are using threads,
# which includes the use of fork() on Windows.
my $error_mode = GetThreadErrorMode();
SetThreadErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX);

system "program_that_would_normal_produce_an_error_dialog.exe";
```

Tie interface:

```perl
# use "if" so that your code will still work on non-windows
use if $^O eq 'MSWin32', 'Win32::ErrorMode';

# 0x3 = SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX
local $Win32::ErrorMode::ErrorMode = 0x3;

system "program_that_would_normal_produce_an_error_dialog.exe";
```

Tie interface thread:

```perl
use if $^O eq 'MSWin32', 'Win32::ErrorMode';

# 0x3 = SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX
local $Win32::ErrorMode::ThreadErrorMode = 0x3;

system "program_that_would_normal_produce_an_error_dialog.exe";
```

# DESCRIPTION

The main motivation for this module is to provide an interface for
turning off those blasted dialog boxes when you try to run .exe
with missing symbols or .dll files.  This is useful when you have
a long running process or a test suite where such failures are
expected, or part of the configuration process.

It may have other applications.

This module also provides a tied interface `$ErrorMode` and
`$ThreadErrorMode`.

# FUNCTIONS

## SetErrorMode

```
SetErrorMode($mode);
```

Controls whether Windows will handle the specified type of serious errors
or whether the process will handle them.

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

```perl
my $mode = GetErrorMode();
```

Retrieves the error mode for the current process.

## SetThreadErrorMode

```
SetThreadErrorMode($mode);
```

Same as ["SetErrorMode"](#seterrormode) above, except it only changes the error mode
on the current thread.

## GetThreadErrorMode

```perl
my $mode = GetThreadErrorMode();
```

Same as ["GetErrorMode"](#geterrormode) above, except it only gets the error mode
for the current thread.

# CAVEATS

All of these functions are available in the oldest supported version
of Windows, which is 8.1.  Previous versions of this module would use
dynamic loading and emulation to support some or all of the functions
on older and newer systems, while maintaining binary compatibility
back to Windows XP.  Older versions could throw and exception for
the threaded interface on older Windows systems.  As of 0.07 the
compatibility code has been removed: this module will only install
and function on Windows 8.1 and later and all functions are fully
supported.

# SEE ALSO

[Win32API::File](https://metacpan.org/pod/Win32API::File) includes an interface to `SetErrorMode`, but not
`GetErrorMode`.  The interface for this function appears to be a
side effect of the main purpose of the module.  The interface to
`SetErrorMode` is not well documented in [Win32API::File](https://metacpan.org/pod/Win32API::File), but is
usable.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015-2024 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
