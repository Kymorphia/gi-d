module HarfBuzz.OtNameEntry;

import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Structure representing a name ID in a particular language.
 */
class OtNameEntry
{
  hb_ot_name_entry_t cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for HarfBuzz.OtNameEntry");

    cInstance = *cast(hb_ot_name_entry_t*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property OtNameId nameId()
  {
    return (cast(hb_ot_name_entry_t*)cPtr).nameId;
  }

  @property void nameId(OtNameId propval)
  {
    (cast(hb_ot_name_entry_t*)cPtr).nameId = propval;
  }

  @property Language language()
  {
    return (cast(hb_ot_name_entry_t*)cPtr).language;
  }

  @property void language(Language propval)
  {
    (cast(hb_ot_name_entry_t*)cPtr).language = propval;
  }
}
