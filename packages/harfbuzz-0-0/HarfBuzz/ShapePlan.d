module HarfBuzz.ShapePlan;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for holding a shaping plan.
 * Shape plans contain information about how HarfBuzz will shape a
 * particular text segment, based on the segment's properties and the
 * capabilities in the font face in use.
 * Shape plans can be queried about how shaping will perform, given a set
 * of specific input parameters $(LPAREN)script, language, direction, features,
 * etc.$(RPAREN).
 */
class ShapePlan : Boxed
{

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
    return hb_gobject_shape_plan_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
