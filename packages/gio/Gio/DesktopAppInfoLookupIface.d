module Gio.DesktopAppInfoLookupIface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDesktopAppInfoLookupIface*)cPtr).gIface);
  }

  alias GetDefaultForUriSchemeFuncType = extern(C) GAppInfo* function(GDesktopAppInfoLookup* lookup, const(char)* uriScheme);

  @property GetDefaultForUriSchemeFuncType getDefaultForUriScheme()
  {
    return (cast(GDesktopAppInfoLookupIface*)cPtr).getDefaultForUriScheme;
  }
}
