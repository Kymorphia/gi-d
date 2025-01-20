module Gsk.RoundedRect;

import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Graphene.Size;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A rectangular region with rounded corners.
 * Application code should normalize rectangles using
 * [Gsk.RoundedRect.normalize]; this function will ensure that
 * the bounds of the rectangle are normalized and ensure that the corner
 * values are positive and the corners do not overlap.
 * All functions taking a `GskRoundedRect` as an argument will internally
 * operate on a normalized copy; all functions returning a `GskRoundedRect`
 * will always return a normalized one.
 * The algorithm used for normalizing corner sizes is described in
 * [the CSS specification](https://drafts.csswg.org/css-backgrounds-3/#border-radius).
 */
class RoundedRect
{
  GskRoundedRect cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.RoundedRect");

    cInstance = *cast(GskRoundedRect*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Rect bounds()
  {
    return new Rect(cast(graphene_rect_t*)&(cast(GskRoundedRect*)cPtr).bounds);
  }

  /**
   * Checks if the given point is inside the rounded rectangle.
   * Params:
   *   point = the point to check
   * Returns: %TRUE if the point is inside the rounded rectangle
   */
  bool containsPoint(Point point)
  {
    bool _retval;
    _retval = gsk_rounded_rect_contains_point(cast(GskRoundedRect*)cPtr, point ? cast(graphene_point_t*)point.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks if the given rect is contained inside the rounded rectangle.
   * Params:
   *   rect = the rectangle to check
   * Returns: %TRUE if the rect is fully contained inside the rounded rectangle
   */
  bool containsRect(Rect rect)
  {
    bool _retval;
    _retval = gsk_rounded_rect_contains_rect(cast(GskRoundedRect*)cPtr, rect ? cast(graphene_rect_t*)rect.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes the given `GskRoundedRect` with the given values.
   * This function will implicitly normalize the `GskRoundedRect`
   * before returning.
   * Params:
   *   bounds = a `graphene_rect_t` describing the bounds
   *   topLeft = the rounding radius of the top left corner
   *   topRight = the rounding radius of the top right corner
   *   bottomRight = the rounding radius of the bottom right corner
   *   bottomLeft = the rounding radius of the bottom left corner
   * Returns: the initialized rectangle
   */
  RoundedRect init_(Rect bounds, Size topLeft, Size topRight, Size bottomRight, Size bottomLeft)
  {
    GskRoundedRect* _cretval;
    _cretval = gsk_rounded_rect_init(cast(GskRoundedRect*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, topLeft ? cast(graphene_size_t*)topLeft.cPtr(false) : null, topRight ? cast(graphene_size_t*)topRight.cPtr(false) : null, bottomRight ? cast(graphene_size_t*)bottomRight.cPtr(false) : null, bottomLeft ? cast(graphene_size_t*)bottomLeft.cPtr(false) : null);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }

  /**
   * Initializes self using the given src rectangle.
   * This function will not normalize the `GskRoundedRect`,
   * so make sure the source is normalized.
   * Params:
   *   src = a `GskRoundedRect`
   * Returns: the initialized rectangle
   */
  RoundedRect initCopy(RoundedRect src)
  {
    GskRoundedRect* _cretval;
    _cretval = gsk_rounded_rect_init_copy(cast(GskRoundedRect*)cPtr, src ? cast(GskRoundedRect*)src.cPtr : null);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }

  /**
   * Initializes self to the given bounds and sets the radius
   * of all four corners to radius.
   * Params:
   *   bounds = a `graphene_rect_t`
   *   radius = the border radius
   * Returns: the initialized rectangle
   */
  RoundedRect initFromRect(Rect bounds, float radius)
  {
    GskRoundedRect* _cretval;
    _cretval = gsk_rounded_rect_init_from_rect(cast(GskRoundedRect*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, radius);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }

  /**
   * Checks if part of the given rect is contained inside the rounded rectangle.
   * Params:
   *   rect = the rectangle to check
   * Returns: %TRUE if the rect intersects with the rounded rectangle
   */
  bool intersectsRect(Rect rect)
  {
    bool _retval;
    _retval = gsk_rounded_rect_intersects_rect(cast(GskRoundedRect*)cPtr, rect ? cast(graphene_rect_t*)rect.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks if all corners of self are right angles and the
   * rectangle covers all of its bounds.
   * This information can be used to decide if [Gsk.ClipNode.new_]
   * or [Gsk.RoundedClipNode.new_] should be called.
   * Returns: %TRUE if the rectangle is rectilinear
   */
  bool isRectilinear()
  {
    bool _retval;
    _retval = gsk_rounded_rect_is_rectilinear(cast(GskRoundedRect*)cPtr);
    return _retval;
  }

  /**
   * Normalizes the passed rectangle.
   * This function will ensure that the bounds of the rectangle
   * are normalized and ensure that the corner values are positive
   * and the corners do not overlap.
   * Returns: the normalized rectangle
   */
  RoundedRect normalize()
  {
    GskRoundedRect* _cretval;
    _cretval = gsk_rounded_rect_normalize(cast(GskRoundedRect*)cPtr);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }

  /**
   * Offsets the bound's origin by dx and dy.
   * The size and corners of the rectangle are unchanged.
   * Params:
   *   dx = the horizontal offset
   *   dy = the vertical offset
   * Returns: the offset rectangle
   */
  RoundedRect offset(float dx, float dy)
  {
    GskRoundedRect* _cretval;
    _cretval = gsk_rounded_rect_offset(cast(GskRoundedRect*)cPtr, dx, dy);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }

  /**
   * Shrinks $(LPAREN)or grows$(RPAREN) the given rectangle by moving the 4 sides
   * according to the offsets given.
   * The corner radii will be changed in a way that tries to keep
   * the center of the corner circle intact. This emulates CSS behavior.
   * This function also works for growing rectangles if you pass
   * negative values for the top, right, bottom or left.
   * Params:
   *   top = How far to move the top side downwards
   *   right = How far to move the right side to the left
   *   bottom = How far to move the bottom side upwards
   *   left = How far to move the left side to the right
   * Returns: the resized `GskRoundedRect`
   */
  RoundedRect shrink(float top, float right, float bottom, float left)
  {
    GskRoundedRect* _cretval;
    _cretval = gsk_rounded_rect_shrink(cast(GskRoundedRect*)cPtr, top, right, bottom, left);
    auto _retval = _cretval ? new RoundedRect(cast(GskRoundedRect*)_cretval) : null;
    return _retval;
  }
}
