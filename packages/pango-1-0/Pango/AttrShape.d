module Pango.AttrShape;

import Gid.gid;
import Pango.Attribute;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttrShape` structure is used to represent attributes which
 * impose shape restrictions.
 */
class AttrShape
{
  PangoAttrShape cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrShape");

    cInstance = *cast(PangoAttrShape*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrShape*)cPtr).attr);
  }

  @property Rectangle inkRect()
  {
    return (cast(PangoAttrShape*)cPtr).inkRect;
  }

  @property void inkRect(Rectangle propval)
  {
    (cast(PangoAttrShape*)cPtr).inkRect = propval;
  }

  @property Rectangle logicalRect()
  {
    return (cast(PangoAttrShape*)cPtr).logicalRect;
  }

  @property void logicalRect(Rectangle propval)
  {
    (cast(PangoAttrShape*)cPtr).logicalRect = propval;
  }

  @property PangoAttrDataCopyFunc copyFunc()
  {
    return (cast(PangoAttrShape*)cPtr).copyFunc;
  }

  @property void copyFunc(PangoAttrDataCopyFunc propval)
  {
    (cast(PangoAttrShape*)cPtr).copyFunc = propval;
  }

  @property GDestroyNotify destroyFunc()
  {
    return (cast(PangoAttrShape*)cPtr).destroyFunc;
  }

  @property void destroyFunc(GDestroyNotify propval)
  {
    (cast(PangoAttrShape*)cPtr).destroyFunc = propval;
  }

  /**
   * Create a new shape attribute.
   * A shape is used to impose a particular ink and logical
   * rectangle on the result of shaping a particular glyph.
   * This might be used, for instance, for embedding a picture
   * or a widget inside a `PangoLayout`.
   * Params:
   *   inkRect = ink rectangle to assign to each character
   *   logicalRect = logical rectangle to assign to each character
   * Returns: the newly allocated
   *   `PangoAttribute`, which should be freed with
   *   [Pango.Attribute.destroy]
   */
  static Attribute new_(Rectangle inkRect, Rectangle logicalRect)
  {
    PangoAttribute* _cretval;
    _cretval = pango_attr_shape_new(&inkRect, &logicalRect);
    auto _retval = _cretval ? new Attribute(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
