module HarfBuzz.OtVarAxisInfo;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for holding variation-axis values.
 * The minimum, default, and maximum values are in un-normalized, user scales.
 * <note>Note: at present, the only flag defined for @flags is
 * #HB_OT_VAR_AXIS_FLAG_HIDDEN.</note>
 */
class OtVarAxisInfo : Boxed
{

  this()
  {
    super(safeMalloc(hb_ot_var_axis_info_t.sizeof), true);
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
    return hb_gobject_ot_var_axis_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property uint axisIndex()
  {
    return (cast(hb_ot_var_axis_info_t*)cPtr).axisIndex;
  }

  @property void axisIndex(uint propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).axisIndex = propval;
  }

  @property Tag tag()
  {
    return (cast(hb_ot_var_axis_info_t*)cPtr).tag;
  }

  @property void tag(Tag propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).tag = propval;
  }

  @property OtNameId nameId()
  {
    return (cast(hb_ot_var_axis_info_t*)cPtr).nameId;
  }

  @property void nameId(OtNameId propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).nameId = propval;
  }

  @property OtVarAxisFlags flags()
  {
    return cast(OtVarAxisFlags)(cast(hb_ot_var_axis_info_t*)cPtr).flags;
  }

  @property void flags(OtVarAxisFlags propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).flags = cast(hb_ot_var_axis_flags_t)propval;
  }

  @property float minValue()
  {
    return (cast(hb_ot_var_axis_info_t*)cPtr).minValue;
  }

  @property void minValue(float propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).minValue = propval;
  }

  @property float defaultValue()
  {
    return (cast(hb_ot_var_axis_info_t*)cPtr).defaultValue;
  }

  @property void defaultValue(float propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).defaultValue = propval;
  }

  @property float maxValue()
  {
    return (cast(hb_ot_var_axis_info_t*)cPtr).maxValue;
  }

  @property void maxValue(float propval)
  {
    (cast(hb_ot_var_axis_info_t*)cPtr).maxValue = propval;
  }
}
