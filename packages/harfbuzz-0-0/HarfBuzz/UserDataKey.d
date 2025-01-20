module HarfBuzz.UserDataKey;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data structure for holding user-data keys.
 */
class UserDataKey : Boxed
{

  this()
  {
    super(safeMalloc(hb_user_data_key_t.sizeof), true);
  }

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
    return hb_gobject_user_data_key_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
