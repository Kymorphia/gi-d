module HarfBuzz.SegmentProperties;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Language;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The structure that holds various text properties of an #hb_buffer_t. Can be
 * set and retrieved using hb_buffer_set_segment_properties() and
 * hb_buffer_get_segment_properties(), respectively.
 */
class SegmentProperties : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_segment_properties_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_segment_properties_get_type();
  }

  @property Direction direction()
  {
    return cast(Direction)cPtr!hb_segment_properties_t.direction;
  }

  @property void direction(Direction propval)
  {
    cPtr!hb_segment_properties_t.direction = cast(hb_direction_t)propval;
  }

  @property Script script()
  {
    return cast(Script)cPtr!hb_segment_properties_t.script;
  }

  @property void script(Script propval)
  {
    cPtr!hb_segment_properties_t.script = cast(hb_script_t)propval;
  }

  @property Language language()
  {
    return new Language(cast(hb_language_t*)&cPtr!hb_segment_properties_t.language);
  }
}
