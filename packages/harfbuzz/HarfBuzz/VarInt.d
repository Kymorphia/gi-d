module HarfBuzz.VarInt;

import GLib.c.functions;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

class VarInt
{
  hb_var_int_t cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for HarfBuzz.VarInt");

    cInstance = *cast(hb_var_int_t*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == hb_var_int_t))
  {
    return cast(T*)&cInstance;
  }

  @property uint u32()
  {
    return cPtr!hb_var_int_t.u32;
  }

  @property void u32(uint propval)
  {
    cPtr!hb_var_int_t.u32 = propval;
  }

  @property int i32()
  {
    return cPtr!hb_var_int_t.i32;
  }

  @property void i32(int propval)
  {
    cPtr!hb_var_int_t.i32 = propval;
  }
}
