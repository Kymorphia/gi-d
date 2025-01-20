module Gsk.BorderNode;

import Gdk.RGBA;
import Gid.gid;
import Gsk.RenderNode;
import Gsk.RoundedRect;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a border.
 */
class BorderNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.BorderNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will stroke a border rectangle inside the
   * given outline.
   * The 4 sides of the border can have different widths and colors.
   * Params:
   *   outline = a `GskRoundedRect` describing the outline of the border
   *   borderWidth = the stroke width of the border on
   *     the top, right, bottom and left side respectively.
   *   borderColor = the color used on the top, right,
   *     bottom and left side.
   * Returns: A new `GskRenderNode`
   */
  this(RoundedRect outline, float[] borderWidth, RGBA[] borderColor)
  {
    GskRenderNode* _cretval;
    assert(!borderWidth || borderWidth.length == 4);
    auto _borderWidth = cast(const(float)*)borderWidth.ptr;
    assert(!borderColor || borderColor.length == 4);
    GdkRGBA[] _tmpborderColor;
    foreach (obj; borderColor)
      _tmpborderColor ~= *cast(GdkRGBA*)obj.cPtr;
    const(GdkRGBA)* _borderColor = _tmpborderColor.ptr;
    _cretval = gsk_border_node_new(outline ? cast(GskRoundedRect*)outline.cPtr : null, _borderWidth, _borderColor);
    this(_cretval, true);
  }

  /**
   * Retrieves the colors of the border.
   * Returns: an array of 4 `GdkRGBA` structs
   *   for the top, right, bottom and left color of the border
   */
  RGBA getColors()
  {
    const(GdkRGBA)* _cretval;
    _cretval = gsk_border_node_get_colors(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RGBA(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the outline of the border.
   * Returns: the outline of the border
   */
  RoundedRect getOutline()
  {
    const(GskRoundedRect)* _cretval;
    _cretval = gsk_border_node_get_outline(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }

  /**
   * Retrieves the stroke widths of the border.
   * Returns: an array of 4 floats
   *   for the top, right, bottom and left stroke width of the border,
   *   respectively
   */
  float[] getWidths()
  {
    const(float)* _cretval;
    _cretval = gsk_border_node_get_widths(cast(GskRenderNode*)cPtr);
    float[] _retval;

    if (_cretval)
    {
      _retval = cast(float[] )_cretval[0 .. 4];
    }
    return _retval;
  }
}
