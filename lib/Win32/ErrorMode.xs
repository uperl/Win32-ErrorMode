#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <windows.h>

/*
 * So it begins...
 *
 * - SetErrorMode() was introduced in XP / 2003
 *   we assume you are using at least XP / 2003
 *
 * - GetErrorMode() was introduced in Vista / 2008
 *   but apparently isn't supported by the version
 *   of Strawberry or MSVC++ that I am testing with
 *   (it does work with cygwin 64 that I am using
 *   I didn't try Strawberry 64, maybe it is a 32
 *   bit problem).  It can also be emulated using
 *   SetErrorMode(), although there is a race
 *   condition if you are using threads (including
 *   forking since this is windows).
 *   Thus:
 *     1. if GetErrorMode() is found dynamically
 *        using GetProcAddress() in kernel32.dll
 *        we use that.
 *     2. if not we emulate it using SetErrorMode()
 *     3. if there is an error resolving the symbol
 *        then we also use the GetErrorMode()
 *        emulation.
 *   This way we maintain binary compatability back
 *   To Windows XP / 2003, and we don't have the
 *   race condition for GetErrorMode() when forking
 *   on Vista / 2008 or better.
 */

typedef unsigned int (*GetErrorMode_t)(void);

static unsigned int FallbackGetErrorMode(void)
{
  unsigned int old;
  old = SetErrorMode(0);
  SetErrorMode(old);
  return old;
}

static GetErrorMode_t myGetErrorMode = NULL;

static void
win32_error_mode_boot()
{
  HMODULE mod;
  
  mod = LoadLibrary("kernel32.dll");
  
  if(mod != NULL)
    myGetErrorMode = (GetErrorMode_t) GetProcAddress(mod, "GetErrorMode");

  if(myGetErrorMode == NULL)
    myGetErrorMode = &FallbackGetErrorMode;

  if(mod == NULL)
    return;
}

MODULE = Win32::ErrorMode PACKAGE = Win32::ErrorMode

BOOT:
    win32_error_mode_boot();

unsigned int
GetErrorMode()
  CODE:
    RETVAL = myGetErrorMode();
  OUTPUT:
    RETVAL

unsigned int
SetErrorMode(mode)
    unsigned int mode

int
_has_real_GetErrorMode()
  CODE:
    RETVAL = myGetErrorMode != &FallbackGetErrorMode;
  OUTPUT:
    RETVAL
