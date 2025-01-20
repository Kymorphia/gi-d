module Gio.ApplicationCommandLineClass;

import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GApplicationCommandLineClass-struct
 * contains private data only.
 */
class ApplicationCommandLineClass
{
  GApplicationCommandLineClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ApplicationCommandLineClass");

    cInstance = *cast(GApplicationCommandLineClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias PrintLiteralFuncType = extern(C) void function(GApplicationCommandLine* cmdline, const(char)* message);

  @property PrintLiteralFuncType printLiteral()
  {
    return (cast(GApplicationCommandLineClass*)cPtr).printLiteral;
  }

  alias PrinterrLiteralFuncType = extern(C) void function(GApplicationCommandLine* cmdline, const(char)* message);

  @property PrinterrLiteralFuncType printerrLiteral()
  {
    return (cast(GApplicationCommandLineClass*)cPtr).printerrLiteral;
  }

  alias GetStdinFuncType = extern(C) GInputStream* function(GApplicationCommandLine* cmdline);

  @property GetStdinFuncType getStdin()
  {
    return (cast(GApplicationCommandLineClass*)cPtr).getStdin;
  }

  alias DoneFuncType = extern(C) void function(GApplicationCommandLine* cmdline);

  @property DoneFuncType done()
  {
    return (cast(GApplicationCommandLineClass*)cPtr).done;
  }
}
