module Graphene.Quad;

import GLib.Boxed;
import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Graphene.Types;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A 4 vertex quadrilateral, as represented by four #graphene_point_t.
 * The contents of a #graphene_quad_t are private and should never be
 * accessed directly.
 */
class Quad : Boxed
{

  this()
  {
    super(safeMalloc(graphene_quad_t.sizeof), true);
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
    return graphene_quad_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_quad_t instance.
   * The contents of the returned instance are undefined.
   * Returns: the newly created #graphene_quad_t instance
   */
  static Quad alloc()
  {
    graphene_quad_t* _cretval;
    _cretval = graphene_quad_alloc();
    auto _retval = _cretval ? new Quad(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Computes the bounding rectangle of q and places it into r.
   * Params:
   *   r = return location for a #graphene_rect_t
   */
  void bounds(out Rect r)
  {
    graphene_rect_t _r;
    graphene_quad_bounds(cast(graphene_quad_t*)cPtr, &_r);
    r = new Rect(cast(void*)&_r, false);
  }

  /**
   * Checks if the given #graphene_quad_t contains the given #graphene_point_t.
   * Params:
   *   p = a #graphene_point_t
   * Returns: `true` if the point is inside the #graphene_quad_t
   */
  bool contains(Point p)
  {
    bool _retval;
    _retval = graphene_quad_contains(cast(graphene_quad_t*)cPtr, p ? cast(graphene_point_t*)p.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the point of a #graphene_quad_t at the given index.
   * Params:
   *   index = the index of the point to retrieve
   * Returns: a #graphene_point_t
   */
  Point getPoint(uint index)
  {
    const(graphene_point_t)* _cretval;
    _cretval = graphene_quad_get_point(cast(graphene_quad_t*)cPtr, index);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quad_t with the given points.
   * Params:
   *   p1 = the first point of the quadrilateral
   *   p2 = the second point of the quadrilateral
   *   p3 = the third point of the quadrilateral
   *   p4 = the fourth point of the quadrilateral
   * Returns: the initialized #graphene_quad_t
   */
  Quad init_(Point p1, Point p2, Point p3, Point p4)
  {
    graphene_quad_t* _cretval;
    _cretval = graphene_quad_init(cast(graphene_quad_t*)cPtr, p1 ? cast(graphene_point_t*)p1.cPtr(false) : null, p2 ? cast(graphene_point_t*)p2.cPtr(false) : null, p3 ? cast(graphene_point_t*)p3.cPtr(false) : null, p4 ? cast(graphene_point_t*)p4.cPtr(false) : null);
    auto _retval = _cretval ? new Quad(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quad_t using an array of points.
   * Params:
   *   points = an array of 4 #graphene_point_t
   * Returns: the initialized #graphene_quad_t
   */
  Quad initFromPoints(Point[] points)
  {
    graphene_quad_t* _cretval;
    assert(!points || points.length == 4);
    graphene_point_t[] _tmppoints;
    foreach (obj; points)
      _tmppoints ~= *cast(graphene_point_t*)obj.cPtr;
    const(graphene_point_t)* _points = _tmppoints.ptr;
    _cretval = graphene_quad_init_from_points(cast(graphene_quad_t*)cPtr, _points);
    auto _retval = _cretval ? new Quad(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quad_t using the four corners of the
   * given #graphene_rect_t.
   * Params:
   *   r = a #graphene_rect_t
   * Returns: the initialized #graphene_quad_t
   */
  Quad initFromRect(Rect r)
  {
    graphene_quad_t* _cretval;
    _cretval = graphene_quad_init_from_rect(cast(graphene_quad_t*)cPtr, r ? cast(graphene_rect_t*)r.cPtr(false) : null);
    auto _retval = _cretval ? new Quad(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
