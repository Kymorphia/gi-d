module HarfBuzz.Feature;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The #hb_feature_t is the structure that holds information about requested
 * feature application. The feature will be applied with the given value to all
 * glyphs which are in clusters between @start (inclusive) and @end (exclusive).
 * Setting start to #HB_FEATURE_GLOBAL_START and end to #HB_FEATURE_GLOBAL_END
 * specifies that the feature always applies to the entire buffer.
 */
class Feature : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_feature_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_feature_get_type();
  }

  @property Tag tag()
  {
    return cPtr!hb_feature_t.tag;
  }

  @property void tag(Tag propval)
  {
    cPtr!hb_feature_t.tag = propval;
  }

  @property uint value()
  {
    return cPtr!hb_feature_t.value;
  }

  @property void value(uint propval)
  {
    cPtr!hb_feature_t.value = propval;
  }

  @property uint start()
  {
    return cPtr!hb_feature_t.start;
  }

  @property void start(uint propval)
  {
    cPtr!hb_feature_t.start = propval;
  }

  @property uint end()
  {
    return cPtr!hb_feature_t.end;
  }

  @property void end(uint propval)
  {
    cPtr!hb_feature_t.end = propval;
  }
}
