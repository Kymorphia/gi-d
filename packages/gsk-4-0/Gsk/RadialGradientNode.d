module Gsk.RadialGradientNode;

import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Gsk.ColorStop;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a radial gradient.
 */
class RadialGradientNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.RadialGradientNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that draws a radial gradient.
   * The radial gradient
   * starts around center. The size of the gradient is dictated by hradius
   * in horizontal orientation and by vradius in vertical orientation.
   * Params:
   *   bounds = the bounds of the node
   *   center = the center of the gradient
   *   hradius = the horizontal radius
   *   vradius = the vertical radius
   *   start = a percentage >\= 0 that defines the start of the gradient around center
   *   end = a percentage >\= 0 that defines the end of the gradient around center
   *   colorStops = a pointer to an array of
   *     `GskColorStop` defining the gradient. The offsets of all color stops
   *     must be increasing. The first stop's offset must be >\= 0 and the last
   *     stop's offset must be <\= 1.
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds, Point center, float hradius, float vradius, float start, float end, ColorStop[] colorStops)
  {
    GskRenderNode* _cretval;
    size_t _nColorStops;
    if (colorStops)
      _nColorStops = cast(size_t)colorStops.length;

    GskColorStop[] _tmpcolorStops;
    foreach (obj; colorStops)
      _tmpcolorStops ~= obj.cInstance;
    const(GskColorStop)* _colorStops = _tmpcolorStops.ptr;
    _cretval = gsk_radial_gradient_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, center ? cast(graphene_point_t*)center.cPtr(false) : null, hradius, vradius, start, end, _colorStops, _nColorStops);
    this(_cretval, true);
  }

  /**
   * Retrieves the center pointer for the gradient.
   * Returns: the center point for the gradient
   */
  Point getCenter()
  {
    const(graphene_point_t)* _cretval;
    _cretval = gsk_radial_gradient_node_get_center(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the color stops in the gradient.
   * Returns: the color stops in the gradient
   */
  ColorStop[] getColorStops()
  {
    const(GskColorStop)* _cretval;
    size_t _cretlength;
    _cretval = gsk_radial_gradient_node_get_color_stops(cast(GskRenderNode*)cPtr, &_cretlength);
    ColorStop[] _retval;

    if (_cretval)
    {
      _retval = new ColorStop[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new ColorStop(cast(void*)&_cretval[i], false);
    }
    return _retval;
  }

  /**
   * Retrieves the end value for the gradient.
   * Returns: the end value for the gradient
   */
  float getEnd()
  {
    float _retval;
    _retval = gsk_radial_gradient_node_get_end(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the horizontal radius for the gradient.
   * Returns: the horizontal radius for the gradient
   */
  float getHradius()
  {
    float _retval;
    _retval = gsk_radial_gradient_node_get_hradius(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the number of color stops in the gradient.
   * Returns: the number of color stops
   */
  size_t getNColorStops()
  {
    size_t _retval;
    _retval = gsk_radial_gradient_node_get_n_color_stops(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the start value for the gradient.
   * Returns: the start value for the gradient
   */
  float getStart()
  {
    float _retval;
    _retval = gsk_radial_gradient_node_get_start(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the vertical radius for the gradient.
   * Returns: the vertical radius for the gradient
   */
  float getVradius()
  {
    float _retval;
    _retval = gsk_radial_gradient_node_get_vradius(cast(GskRenderNode*)cPtr);
    return _retval;
  }
}
