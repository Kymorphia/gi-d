module HarfBuzz.Variation;

import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for holding variation data. Registered OpenType
 * variation-axis tags are listed in
 * [OpenType Axis Tag Registry](https://docs.microsoft.com/en-us/typography/opentype/spec/dvaraxisreg).
 */
class Variation
{
  hb_variation_t cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for HarfBuzz.Variation");

    cInstance = *cast(hb_variation_t*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Tag tag()
  {
    return (cast(hb_variation_t*)cPtr).tag;
  }

  @property void tag(Tag propval)
  {
    (cast(hb_variation_t*)cPtr).tag = propval;
  }

  @property float value()
  {
    return (cast(hb_variation_t*)cPtr).value;
  }

  @property void value(float propval)
  {
    (cast(hb_variation_t*)cPtr).value = propval;
  }
}
