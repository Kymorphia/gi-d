module Gsk.Path;

import GLib.Boxed;
import GLib.String;
import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Gsk.Stroke;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;
import cairo.Context;

/**
 * A `GskPath` describes lines and curves that are more complex
 * than simple rectangles.
 * Paths can used for rendering $(LPAREN)filling or stroking$(RPAREN) and for animations
 * $(LPAREN)e.g. as trajectories$(RPAREN).
 * `GskPath` is an immutable, opaque, reference-counted struct.
 * After creation, you cannot change the types it represents. Instead,
 * new `GskPath` objects have to be created. The [Gsk.PathBuilder]
 * structure is meant to help in this endeavor.
 * Conceptually, a path consists of zero or more contours $(LPAREN)continuous, connected
 * curves$(RPAREN), each of which may or may not be closed. Contours are typically
 * constructed from Bézier segments.
 * <picture>
 * <source srcset\="path-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
 * <img alt\="A Path" src\="path-light.png">
 * </picture>
 */
class Path : Boxed
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
    return gsk_path_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Calls func for every operation of the path.
   * Note that this may only approximate self, because paths can contain
   * optimizations for various specialized contours, and depending on the
   * flags, the path may be decomposed into simpler curves than the ones
   * that it contained originally.
   * This function serves two purposes:
   * - When the flags allow everything, it provides access to the raw,
   * unmodified data of the path.
   * - When the flags disallow certain operations, it provides
   * an approximation of the path using just the allowed operations.
   * Params:
   *   flags = flags to pass to the foreach function. See [Gsk]
   *     for details about flags
   *   func = the function to call for operations
   * Returns: `FALSE` if func returned FALSE`, `TRUE` otherwise.
   */
  bool foreach_(PathForeachFlags flags, PathForeachFunc func)
  {
    static PathForeachFunc _static_func;

    extern(C) bool _funcCallback(GskPathOperation op, const(graphene_point_t)* pts, size_t nPts, float weight, void* userData)
    {
      bool _retval = _static_func(op, pts ? new Point(cast(void*)pts, false) : null, nPts, weight);
      return _retval;
    }

    _static_func = func;
    bool _retval;
    auto _func = freezeDelegate(cast(void*)&func);
    _retval = gsk_path_foreach(cast(GskPath*)cPtr, flags, &_funcCallback, _func);
    _static_func = null;
    return _retval;
  }

  /**
   * Computes the bounds of the given path.
   * The returned bounds may be larger than necessary, because this
   * function aims to be fast, not accurate. The bounds are guaranteed
   * to contain the path.
   * It is possible that the returned rectangle has 0 width and/or height.
   * This can happen when the path only describes a point or an
   * axis-aligned line.
   * If the path is empty, `FALSE` is returned and bounds are set to
   * [Graphene.Rect.zero]. This is different from the case where the path
   * is a single point at the origin, where the bounds will also be set to
   * the zero rectangle but `TRUE` will be returned.
   * Params:
   *   bounds = the bounds of the given path
   * Returns: `TRUE` if the path has bounds, `FALSE` if the path is known
   *   to be empty and have no bounds.
   */
  bool getBounds(out Rect bounds)
  {
    bool _retval;
    graphene_rect_t _bounds;
    _retval = gsk_path_get_bounds(cast(GskPath*)cPtr, &_bounds);
    bounds = new Rect(cast(void*)&_bounds, false);
    return _retval;
  }

  /**
   * Computes the bounds for stroking the given path with the
   * parameters in stroke.
   * The returned bounds may be larger than necessary, because this
   * function aims to be fast, not accurate. The bounds are guaranteed
   * to contain the area affected by the stroke, including protrusions
   * like miters.
   * Params:
   *   stroke = stroke parameters
   *   bounds = the bounds to fill in
   * Returns: `TRUE` if the path has bounds, `FALSE` if the path is known
   *   to be empty and have no bounds.
   */
  bool getStrokeBounds(Stroke stroke, out Rect bounds)
  {
    bool _retval;
    graphene_rect_t _bounds;
    _retval = gsk_path_get_stroke_bounds(cast(GskPath*)cPtr, stroke ? cast(GskStroke*)stroke.cPtr(false) : null, &_bounds);
    bounds = new Rect(cast(void*)&_bounds, false);
    return _retval;
  }

  /**
   * Returns whether the given point is inside the area
   * that would be affected if the path was filled according
   * to fill_rule.
   * Note that this function assumes that filling a contour
   * implicitly closes it.
   * Params:
   *   point = the point to test
   *   fillRule = the fill rule to follow
   * Returns: `TRUE` if point is inside
   */
  bool inFill(Point point, FillRule fillRule)
  {
    bool _retval;
    _retval = gsk_path_in_fill(cast(GskPath*)cPtr, point ? cast(graphene_point_t*)point.cPtr(false) : null, fillRule);
    return _retval;
  }

  /**
   * Returns if the path represents a single closed
   * contour.
   * Returns: `TRUE` if the path is closed
   */
  bool isClosed()
  {
    bool _retval;
    _retval = gsk_path_is_closed(cast(GskPath*)cPtr);
    return _retval;
  }

  /**
   * Checks if the path is empty, i.e. contains no lines or curves.
   * Returns: `TRUE` if the path is empty
   */
  bool isEmpty()
  {
    bool _retval;
    _retval = gsk_path_is_empty(cast(GskPath*)cPtr);
    return _retval;
  }

  /**
   * Converts self into a human-readable string representation suitable
   * for printing.
   * The string is compatible with $(LPAREN)a superset of$(RPAREN)
   * [SVG path syntax](https://www.w3.org/TR/SVG11/paths.html#PathData),
   * see [Gsk.Path.parse] for a summary of the syntax.
   * Params:
   *   string_ = The string to print into
   */
  void print(String string_)
  {
    gsk_path_print(cast(GskPath*)cPtr, string_ ? cast(GString*)string_.cPtr(false) : null);
  }

  /**
   * Appends the given path to the given cairo context for drawing
   * with Cairo.
   * This may cause some suboptimal conversions to be performed as
   * Cairo does not support all features of `GskPath`.
   * This function does not clear the existing Cairo path. Call
   * [cairo.Context.newPath] if you want this.
   * Params:
   *   cr = a cairo context
   */
  void toCairo(Context cr)
  {
    gsk_path_to_cairo(cast(GskPath*)cPtr, cr ? cast(cairo_t*)cr.cPtr(false) : null);
  }

  /**
   * Converts the path into a string that is suitable for printing.
   * You can use this function in a debugger to get a quick overview
   * of the path.
   * This is a wrapper around [Gsk.Path.print], see that function
   * for details.
   * Returns: A new string for self
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gsk_path_to_string(cast(GskPath*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * This is a convenience function that constructs a `GskPath`
   * from a serialized form.
   * The string is expected to be in $(LPAREN)a superset of$(RPAREN)
   * [SVG path syntax](https://www.w3.org/TR/SVG11/paths.html#PathData),
   * as e.g. produced by [Gsk.Path.toString_].
   * A high-level summary of the syntax:
   * - `M x y` Move to `$(LPAREN)x, y$(RPAREN)`
   * - `L x y` Add a line from the current point to `$(LPAREN)x, y$(RPAREN)`
   * - `Q x1 y1 x2 y2` Add a quadratic Bézier from the current point to `$(LPAREN)x2, y2$(RPAREN)`, with control point `$(LPAREN)x1, y1$(RPAREN)`
   * - `C x1 y1 x2 y2 x3 y3` Add a cubic Bézier from the current point to `$(LPAREN)x3, y3$(RPAREN)`, with control points `$(LPAREN)x1, y1$(RPAREN)` and `$(LPAREN)x2, y2$(RPAREN)`
   * - `Z` Close the contour by drawing a line back to the start point
   * - `H x` Add a horizontal line from the current point to the given x value
   * - `V y` Add a vertical line from the current point to the given y value
   * - `T x2 y2` Add a quadratic Bézier, using the reflection of the previous segments' control point as control point
   * - `S x2 y2 x3 y3` Add a cubic Bézier, using the reflection of the previous segments' second control point as first control point
   * - `A rx ry r l s x y` Add an elliptical arc from the current point to `$(LPAREN)x, y$(RPAREN)` with radii rx and ry. See the SVG documentation for how the other parameters influence the arc.
   * - `O x1 y1 x2 y2 w` Add a rational quadratic Bézier from the current point to `$(LPAREN)x2, y2$(RPAREN)` with control point `$(LPAREN)x1, y1$(RPAREN)` and weight `w`.
   * All the commands have lowercase variants that interpret coordinates
   * relative to the current point.
   * The `O` command is an extension that is not supported in SVG.
   * Params:
   *   string_ = a string
   * Returns: a new `GskPath`, or `NULL` if string could not be parsed
   */
  static Path parse(string string_)
  {
    GskPath* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = gsk_path_parse(_string_);
    auto _retval = _cretval ? new Path(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
