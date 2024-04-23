module HarfBuzz.VarNum;

import GLib.c.functions;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

class VarNum
{
  hb_var_num_t cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for HarfBuzz.VarNum");

    cInstance = *cast(hb_var_num_t*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == hb_var_num_t))
  {
    return cast(T*)&cInstance;
  }

  @property float f()
  {
    return cPtr!hb_var_num_t.f;
  }

  @property void f(float propval)
  {
    cPtr!hb_var_num_t.f = propval;
  }

  @property uint u32()
  {
    return cPtr!hb_var_num_t.u32;
  }

  @property void u32(uint propval)
  {
    cPtr!hb_var_num_t.u32 = propval;
  }

  @property int i32()
  {
    return cPtr!hb_var_num_t.i32;
  }

  @property void i32(int propval)
  {
    cPtr!hb_var_num_t.i32 = propval;
  }
}
