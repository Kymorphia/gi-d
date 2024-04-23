module HarfBuzz.OtVarAxisInfo;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for holding variation-axis values.
 *
 * The minimum, default, and maximum values are in un-normalized, user scales.
 *
 * <note>Note: at present, the only flag defined for @flags is
 * #HB_OT_VAR_AXIS_FLAG_HIDDEN.</note>
 */
class OtVarAxisInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_ot_var_axis_info_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_ot_var_axis_info_get_type();
  }

  @property uint axisIndex()
  {
    return cPtr!hb_ot_var_axis_info_t.axisIndex;
  }

  @property void axisIndex(uint propval)
  {
    cPtr!hb_ot_var_axis_info_t.axisIndex = propval;
  }

  @property Tag tag()
  {
    return cPtr!hb_ot_var_axis_info_t.tag;
  }

  @property void tag(Tag propval)
  {
    cPtr!hb_ot_var_axis_info_t.tag = propval;
  }

  @property OtNameId nameId()
  {
    return cPtr!hb_ot_var_axis_info_t.nameId;
  }

  @property void nameId(OtNameId propval)
  {
    cPtr!hb_ot_var_axis_info_t.nameId = propval;
  }

  @property OtVarAxisFlags flags()
  {
    return cast(OtVarAxisFlags)cPtr!hb_ot_var_axis_info_t.flags;
  }

  @property void flags(OtVarAxisFlags propval)
  {
    cPtr!hb_ot_var_axis_info_t.flags = cast(hb_ot_var_axis_flags_t)propval;
  }

  @property float minValue()
  {
    return cPtr!hb_ot_var_axis_info_t.minValue;
  }

  @property void minValue(float propval)
  {
    cPtr!hb_ot_var_axis_info_t.minValue = propval;
  }

  @property float defaultValue()
  {
    return cPtr!hb_ot_var_axis_info_t.defaultValue;
  }

  @property void defaultValue(float propval)
  {
    cPtr!hb_ot_var_axis_info_t.defaultValue = propval;
  }

  @property float maxValue()
  {
    return cPtr!hb_ot_var_axis_info_t.maxValue;
  }

  @property void maxValue(float propval)
  {
    cPtr!hb_ot_var_axis_info_t.maxValue = propval;
  }
}
