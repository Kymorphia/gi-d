module Gsk.PathMeasure;

import GLib.Boxed;
import Gid.gid;
import Gsk.Path;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * `GskPathMeasure` is an object that allows measurements
 * on `GskPath`s such as determining the length of the path.
 * Many measuring operations require sampling the path length
 * at intermediate points. Therefore, a `GskPathMeasure` has
 * a tolerance that determines what precision is required
 * for such approximations.
 * A `GskPathMeasure` struct is a reference counted struct
 * and should be treated as opaque.
 */
class PathMeasure : Boxed
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
    return gsk_path_measure_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a measure object for the given path with the
   * default tolerance.
   * Params:
   *   path = the path to measure
   * Returns: a new `GskPathMeasure` representing path
   */
  this(Path path)
  {
    GskPathMeasure* _cretval;
    _cretval = gsk_path_measure_new(path ? cast(GskPath*)path.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a measure object for the given path and tolerance.
   * Params:
   *   path = the path to measure
   *   tolerance = the tolerance for measuring operations
   * Returns: a new `GskPathMeasure` representing path
   */
  static PathMeasure newWithTolerance(Path path, float tolerance)
  {
    GskPathMeasure* _cretval;
    _cretval = gsk_path_measure_new_with_tolerance(path ? cast(GskPath*)path.cPtr(false) : null, tolerance);
    auto _retval = _cretval ? new PathMeasure(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the length of the path being measured.
   * The length is cached, so this function does not do any work.
   * Returns: The length of the path measured by self
   */
  float getLength()
  {
    float _retval;
    _retval = gsk_path_measure_get_length(cast(GskPathMeasure*)cPtr);
    return _retval;
  }

  /**
   * Returns the path that the measure was created for.
   * Returns: the path of self
   */
  Path getPath()
  {
    GskPath* _cretval;
    _cretval = gsk_path_measure_get_path(cast(GskPathMeasure*)cPtr);
    auto _retval = _cretval ? new Path(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the tolerance that the measure was created with.
   * Returns: the tolerance of self
   */
  float getTolerance()
  {
    float _retval;
    _retval = gsk_path_measure_get_tolerance(cast(GskPathMeasure*)cPtr);
    return _retval;
  }
}
