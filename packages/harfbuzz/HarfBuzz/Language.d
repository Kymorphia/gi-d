module HarfBuzz.Language;

import Gid.Gid;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for languages. Each #hb_language_t corresponds to a BCP 47
 * language tag.
 */
class Language
{
  hb_language_t cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for HarfBuzz.Language");

    cInstancePtr = cast(hb_language_t)ptr;

    this.owned = owned;
  }

  T cPtr(T)()
  if (is(T == hb_language_t))
  {
    return cast(T)cInstancePtr;
  }
}
