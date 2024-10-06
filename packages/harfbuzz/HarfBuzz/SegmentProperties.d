module HarfBuzz.SegmentProperties;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The structure that holds various text properties of an #hb_buffer_t. Can be
 * set and retrieved using [HarfBuzz.Global.bufferSetSegmentProperties] and
 * [HarfBuzz.Global.bufferGetSegmentProperties], respectively.
 */
class SegmentProperties : Boxed
{

  this()
  {
    super(safeMalloc(hb_segment_properties_t.sizeof), true);
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
    return hb_gobject_segment_properties_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Direction direction()
  {
    return cast(Direction)(cast(hb_segment_properties_t*)cPtr).direction;
  }

  @property void direction(Direction propval)
  {
    (cast(hb_segment_properties_t*)cPtr).direction = cast(hb_direction_t)propval;
  }

  @property Script script()
  {
    return cast(Script)(cast(hb_segment_properties_t*)cPtr).script;
  }

  @property void script(Script propval)
  {
    (cast(hb_segment_properties_t*)cPtr).script = cast(hb_script_t)propval;
  }

  @property Language language()
  {
    return (cast(hb_segment_properties_t*)cPtr).language;
  }

  @property void language(Language propval)
  {
    (cast(hb_segment_properties_t*)cPtr).language = propval;
  }
}
