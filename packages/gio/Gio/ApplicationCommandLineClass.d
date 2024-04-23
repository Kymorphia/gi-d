module Gio.ApplicationCommandLineClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.ApplicationCommandLine;
import Gio.InputStream;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GApplicationCommandLineClass))
  {
    return cast(T*)&cInstance;
  }

  alias PrintLiteralFuncType = extern(C) void function(GApplicationCommandLine* cmdline, const(char)* message);

  @property PrintLiteralFuncType printLiteral()
  {
    return cPtr!GApplicationCommandLineClass.printLiteral;
  }

  alias PrinterrLiteralFuncType = extern(C) void function(GApplicationCommandLine* cmdline, const(char)* message);

  @property PrinterrLiteralFuncType printerrLiteral()
  {
    return cPtr!GApplicationCommandLineClass.printerrLiteral;
  }

  alias GetStdinFuncType = extern(C) GInputStream* function(GApplicationCommandLine* cmdline);

  @property GetStdinFuncType getStdin()
  {
    return cPtr!GApplicationCommandLineClass.getStdin;
  }
}
