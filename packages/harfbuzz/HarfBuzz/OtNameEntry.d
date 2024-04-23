module HarfBuzz.OtNameEntry;

import GLib.c.functions;
import Gid.Gid;
import HarfBuzz.Language;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == hb_ot_name_entry_t))
  {
    return cast(T*)&cInstance;
  }

  @property OtNameId nameId()
  {
    return cPtr!hb_ot_name_entry_t.nameId;
  }

  @property void nameId(OtNameId propval)
  {
    cPtr!hb_ot_name_entry_t.nameId = propval;
  }

  @property Language language()
  {
    return new Language(cast(hb_language_t*)&cPtr!hb_ot_name_entry_t.language);
  }
}
