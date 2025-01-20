module Gio.UnixMountEntry;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Defines a Unix mount entry $(LPAREN)e.g. <filename>/media/cdrom</filename>$(RPAREN).
 * This corresponds roughly to a mtab entry.
 */
class UnixMountEntry : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_unix_mount_entry_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
