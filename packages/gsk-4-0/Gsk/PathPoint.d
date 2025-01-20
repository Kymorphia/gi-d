module Gsk.PathPoint;

import GLib.Boxed;
import Gid.gid;
import Graphene.Point;
import Graphene.Vec2;
import Gsk.Path;
import Gsk.PathMeasure;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * `GskPathPoint` is an opaque type representing a point on a path.
 * It can be queried for properties of the path at that point, such as
 * its tangent or its curvature.
 * To obtain a `GskPathPoint`, use [Gsk.Path.getClosestPoint],
 * [Gsk.Path.getStartPoint], [Gsk.Path.getEndPoint]
 * or [Gsk.PathMeasure.getPoint].
 * Note that `GskPathPoint` structs are meant to be stack-allocated,
 * and don't hold a reference to the path object they are obtained from.
 * It is the callers responsibility to keep a reference to the path
 * as long as the `GskPathPoint` is used.
 */
class PathPoint : Boxed
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
    return gsk_path_point_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns whether point1 is before or after point2.
   * Params:
   *   point2 = another `GskPathPoint`
   * Returns: -1 if point1 is before point2,
   *   1 if point1 is after point2,
   *   0 if they are equal
   */
  int compare(PathPoint point2)
  {
    int _retval;
    _retval = gsk_path_point_compare(cast(GskPathPoint*)cPtr, point2 ? cast(GskPathPoint*)point2.cPtr(false) : null);
    return _retval;
  }

  PathPoint copy()
  {
    GskPathPoint* _cretval;
    _cretval = gsk_path_point_copy(cast(GskPathPoint*)cPtr);
    auto _retval = _cretval ? new PathPoint(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether the two path points refer to the same
   * location on all paths.
   * Note that the start- and endpoint of a closed contour
   * will compare nonequal according to this definition.
   * Use [Gsk.Path.isClosed] to find out if the
   * start- and endpoint of a concrete path refer to the
   * same location.
   * Params:
   *   point2 = another `GskPathPoint`
   * Returns: `TRUE` if point1 and point2 are equal
   */
  bool equal(PathPoint point2)
  {
    bool _retval;
    _retval = gsk_path_point_equal(cast(GskPathPoint*)cPtr, point2 ? cast(GskPathPoint*)point2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Calculates the curvature of the path at the point.
   * Optionally, returns the center of the osculating circle as well.
   * The curvature is the inverse of the radius of the osculating circle.
   * Lines have a curvature of zero $(LPAREN)indicating an osculating circle of
   * infinite radius. In this case, the center is not modified.
   * Circles with a radius of zero have `INFINITY` as curvature
   * Note that certain points on a path may not have a single curvature,
   * such as sharp turns. At such points, there are two curvatures --
   * the $(LPAREN)limit of$(RPAREN) the curvature of the path going into the point,
   * and the $(LPAREN)limit of$(RPAREN) the curvature of the path coming out of it.
   * The direction argument lets you choose which one to get.
   * <picture>
   * <source srcset\="curvature-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Osculating circle" src\="curvature-light.png">
   * </picture>
   * Params:
   *   path = the path that point is on
   *   direction = the direction for which to return the curvature
   *   center = Return location for
   *     the center of the osculating circle
   * Returns: The curvature of the path at the given point
   */
  float getCurvature(Path path, PathDirection direction, out Point center)
  {
    float _retval;
    graphene_point_t _center;
    _retval = gsk_path_point_get_curvature(cast(GskPathPoint*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, direction, &_center);
    center = new Point(cast(void*)&_center, false);
    return _retval;
  }

  /**
   * Returns the distance from the beginning of the path
   * to point.
   * Params:
   *   measure = a `GskPathMeasure` for the path
   * Returns: the distance of point
   */
  float getDistance(PathMeasure measure)
  {
    float _retval;
    _retval = gsk_path_point_get_distance(cast(GskPathPoint*)cPtr, measure ? cast(GskPathMeasure*)measure.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets the position of the point.
   * Params:
   *   path = the path that point is on
   *   position = Return location for
   *     the coordinates of the point
   */
  void getPosition(Path path, out Point position)
  {
    graphene_point_t _position;
    gsk_path_point_get_position(cast(GskPathPoint*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, &_position);
    position = new Point(cast(void*)&_position, false);
  }

  /**
   * Gets the direction of the tangent at a given point.
   * This is a convenience variant of [Gsk.PathPoint.getTangent]
   * that returns the angle between the tangent and the X axis. The angle
   * can e.g. be used in
   * [[Gtk.Snapshot.rotate]](../gtk4/method.Snapshot.rotate.html).
   * Params:
   *   path = the path that point is on
   *   direction = the direction for which to return the rotation
   * Returns: the angle between the tangent and the X axis, in degrees
   */
  float getRotation(Path path, PathDirection direction)
  {
    float _retval;
    _retval = gsk_path_point_get_rotation(cast(GskPathPoint*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, direction);
    return _retval;
  }

  /**
   * Gets the tangent of the path at the point.
   * Note that certain points on a path may not have a single
   * tangent, such as sharp turns. At such points, there are
   * two tangents -- the direction of the path going into the
   * point, and the direction coming out of it. The direction
   * argument lets you choose which one to get.
   * If the path is just a single point $(LPAREN)e.g. a circle with
   * radius zero$(RPAREN), then tangent is set to `0, 0`.
   * If you want to orient something in the direction of the
   * path, [Gsk.PathPoint.getRotation] may be more
   * convenient to use.
   * Params:
   *   path = the path that point is on
   *   direction = the direction for which to return the tangent
   *   tangent = Return location for
   *     the tangent at the point
   */
  void getTangent(Path path, PathDirection direction, out Vec2 tangent)
  {
    graphene_vec2_t _tangent;
    gsk_path_point_get_tangent(cast(GskPathPoint*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, direction, &_tangent);
    tangent = new Vec2(cast(void*)&_tangent, false);
  }
}
