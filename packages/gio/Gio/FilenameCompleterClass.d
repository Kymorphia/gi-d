module Gio.FilenameCompleterClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.FilenameCompleter;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FilenameCompleterClass
{
  GFilenameCompleterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FilenameCompleterClass");

    cInstance = *cast(GFilenameCompleterClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFilenameCompleterClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GFilenameCompleterClass.parentClass);
  }

  alias GotCompletionDataFuncType = extern(C) void function(GFilenameCompleter* filenameCompleter);

  @property GotCompletionDataFuncType gotCompletionData()
  {
    return cPtr!GFilenameCompleterClass.gotCompletionData;
  }
}
