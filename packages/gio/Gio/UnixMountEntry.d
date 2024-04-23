module Gio.UnixMountEntry;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * Defines a Unix mount entry (e.g. <filename>/media/cdrom</filename>).
 * This corresponds roughly to a mtab entry.
 */
class UnixMountEntry : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GUnixMountEntry))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_unix_mount_entry_get_type();
  }
}
