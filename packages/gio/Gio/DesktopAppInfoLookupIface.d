module Gio.DesktopAppInfoLookupIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AppInfo;
import Gio.DesktopAppInfoLookup;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Interface that is used by backends to associate default
 * handlers with URI schemes.
 */
class DesktopAppInfoLookupIface
{
  GDesktopAppInfoLookupIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DesktopAppInfoLookupIface");

    cInstance = *cast(GDesktopAppInfoLookupIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDesktopAppInfoLookupIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDesktopAppInfoLookupIface.gIface);
  }

  alias GetDefaultForUriSchemeFuncType = extern(C) GAppInfo* function(GDesktopAppInfoLookup* lookup, const(char)* uriScheme);

  @property GetDefaultForUriSchemeFuncType getDefaultForUriScheme()
  {
    return cPtr!GDesktopAppInfoLookupIface.getDefaultForUriScheme;
  }
}
