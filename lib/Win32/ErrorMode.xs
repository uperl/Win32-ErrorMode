#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <windows.h>

MODULE = Win32::ErrorMode PACKAGE = Win32::ErrorMode

unsigned int
GetErrorMode()

void
SetErrorMode(umode)
    unsigned int umode
