module Gsk.ConicGradientNode;

import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Gsk.ColorStop;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a conic gradient.
 */
class ConicGradientNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ConicGradientNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that draws a conic gradient.
   * The conic gradient
   * starts around center in the direction of rotation. A rotation of 0 means
   * that the gradient points up. Color stops are then added clockwise.
   * Params:
   *   bounds = the bounds of the node
   *   center = the center of the gradient
   *   rotation = the rotation of the gradient in degrees
   *   colorStops = a pointer to an array of
   *     `GskColorStop` defining the gradient. The offsets of all color stops
   *     must be increasing. The first stop's offset must be >\= 0 and the last
   *     stop's offset must be <\= 1.
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds, Point center, float rotation, ColorStop[] colorStops)
  {
    GskRenderNode* _cretval;
    size_t _nColorStops;
    if (colorStops)
      _nColorStops = cast(size_t)colorStops.length;

    GskColorStop[] _tmpcolorStops;
    foreach (obj; colorStops)
      _tmpcolorStops ~= obj.cInstance;
    const(GskColorStop)* _colorStops = _tmpcolorStops.ptr;
    _cretval = gsk_conic_gradient_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, center ? cast(graphene_point_t*)center.cPtr(false) : null, rotation, _colorStops, _nColorStops);
    this(_cretval, true);
  }

  /**
   * Retrieves the angle for the gradient in radians, normalized in [0, 2 * PI].
   * The angle is starting at the top and going clockwise, as expressed
   * in the css specification:
   * angle \= 90 - [Gsk.ConicGradientNode.getRotation]
   * Returns: the angle for the gradient
   */
  float getAngle()
  {
    float _retval;
    _retval = gsk_conic_gradient_node_get_angle(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the center pointer for the gradient.
   * Returns: the center point for the gradient
   */
  Point getCenter()
  {
    const(graphene_point_t)* _cretval;
    _cretval = gsk_conic_gradient_node_get_center(cast(GskRenderNode*)cPtr);
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
    _cretval = gsk_conic_gradient_node_get_color_stops(cast(GskRenderNode*)cPtr, &_cretlength);
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
   * Retrieves the number of color stops in the gradient.
   * Returns: the number of color stops
   */
  size_t getNColorStops()
  {
    size_t _retval;
    _retval = gsk_conic_gradient_node_get_n_color_stops(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the rotation for the gradient in degrees.
   * Returns: the rotation for the gradient
   */
  float getRotation()
  {
    float _retval;
    _retval = gsk_conic_gradient_node_get_rotation(cast(GskRenderNode*)cPtr);
    return _retval;
  }
}
