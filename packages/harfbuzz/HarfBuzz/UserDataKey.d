module HarfBuzz.UserDataKey;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data structure for holding user-data keys.
 */
class UserDataKey : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_user_data_key_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_user_data_key_get_type();
  }
}
