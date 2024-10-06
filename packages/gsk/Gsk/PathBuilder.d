module Gsk.PathBuilder;

import GLib.Boxed;
import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Gsk.Path : DGskPath = Path;
import Gsk.PathPoint;
import Gsk.RoundedRect;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;
import Pango.Layout;
import cairo.Path;

/**
 * `GskPathBuilder` is an auxiliary object for constructing
 * `GskPath` objects.
 * A path is constructed like this:
 * |[<!-- language\="C" -->
 * GskPath *
 * construct_path $(LPAREN)void$(RPAREN)
 * {
 * GskPathBuilder *builder;
 * builder \= gsk_path_builder_new $(LPAREN)$(RPAREN);
 * // add contours to the path here
 * return gsk_path_builder_free_to_path $(LPAREN)builder$(RPAREN);
 * ]|
 * Adding contours to the path can be done in two ways.
 * The easiest option is to use the `gsk_path_builder_add_*` group
 * of functions that add predefined contours to the current path,
 * either common shapes like [Gsk.PathBuilder.addCircle]
 * or by adding from other paths like [Gsk.PathBuilder.addPath].
 * The `gsk_path_builder_add_*` methods always add complete contours,
 * and do not use or modify the current point.
 * The other option is to define each line and curve manually with
 * the `gsk_path_builder_*_to` group of functions. You start with
 * a call to [Gsk.PathBuilder.moveTo] to set the starting point
 * and then use multiple calls to any of the drawing functions to
 * move the pen along the plane. Once you are done, you can call
 * [Gsk.PathBuilder.close] to close the path by connecting it
 * back with a line to the starting point.
 * This is similar to how paths are drawn in Cairo.
 * Note that `GskPathBuilder` will reduce the degree of added Bézier
 * curves as much as possible, to simplify rendering.
 */
class PathBuilder : Boxed
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
    return gsk_path_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `GskPathBuilder` object.
   * The resulting builder would create an empty `GskPath`.
   * Use addition functions to add types to it.
   * Returns: a new `GskPathBuilder`
   */
  this()
  {
    GskPathBuilder* _cretval;
    _cretval = gsk_path_builder_new();
    this(_cretval, true);
  }

  /**
   * Adds a Cairo path to the builder.
   * You can use [cairo.Context.copyPath] to access the path
   * from a Cairo context.
   * Params:
   *   path =
   */
  void addCairoPath(Path path)
  {
    gsk_path_builder_add_cairo_path(cast(GskPathBuilder*)cPtr, path ? cast(cairo_path_t*)path.cPtr(false) : null);
  }

  /**
   * Adds a circle with the center and radius.
   * The path is going around the circle in clockwise direction.
   * If radius is zero, the contour will be a closed point.
   * Params:
   *   center = the center of the circle
   *   radius = the radius of the circle
   */
  void addCircle(Point center, float radius)
  {
    gsk_path_builder_add_circle(cast(GskPathBuilder*)cPtr, center ? cast(graphene_point_t*)center.cPtr(false) : null, radius);
  }

  /**
   * Adds the outlines for the glyphs in layout to the builder.
   * Params:
   *   layout = the pango layout to add
   */
  void addLayout(Layout layout)
  {
    gsk_path_builder_add_layout(cast(GskPathBuilder*)cPtr, layout ? cast(PangoLayout*)layout.cPtr(false) : null);
  }

  /**
   * Appends all of path to the builder.
   * Params:
   *   path = the path to append
   */
  void addPath(DGskPath path)
  {
    gsk_path_builder_add_path(cast(GskPathBuilder*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null);
  }

  /**
   * Adds rect as a new contour to the path built by the builder.
   * The path is going around the rectangle in clockwise direction.
   * If the the width or height are 0, the path will be a closed
   * horizontal or vertical line. If both are 0, it'll be a closed dot.
   * Params:
   *   rect = The rectangle to create a path for
   */
  void addRect(Rect rect)
  {
    gsk_path_builder_add_rect(cast(GskPathBuilder*)cPtr, rect ? cast(graphene_rect_t*)rect.cPtr(false) : null);
  }

  /**
   * Appends all of path to the builder, in reverse order.
   * Params:
   *   path = the path to append
   */
  void addReversePath(DGskPath path)
  {
    gsk_path_builder_add_reverse_path(cast(GskPathBuilder*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null);
  }

  /**
   * Adds rect as a new contour to the path built in self.
   * The path is going around the rectangle in clockwise direction.
   * Params:
   *   rect = the rounded rect
   */
  void addRoundedRect(RoundedRect rect)
  {
    gsk_path_builder_add_rounded_rect(cast(GskPathBuilder*)cPtr, rect ? cast(GskRoundedRect*)rect.cPtr : null);
  }

  /**
   * Adds to self the segment of path from start to end.
   * If start is equal to or after end, the path will first add the
   * segment from start to the end of the path, and then add the segment
   * from the beginning to end. If the path is closed, these segments
   * will be connected.
   * Note that this method always adds a path with the given start point
   * and end point. To add a closed path, use [Gsk.PathBuilder.addPath].
   * Params:
   *   path = the `GskPath` to take the segment to
   *   start = the point on path to start at
   *   end = the point on path to end at
   */
  void addSegment(DGskPath path, PathPoint start, PathPoint end)
  {
    gsk_path_builder_add_segment(cast(GskPathBuilder*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, start ? cast(GskPathPoint*)start.cPtr(false) : null, end ? cast(GskPathPoint*)end.cPtr(false) : null);
  }

  /**
   * Adds an elliptical arc from the current point to x3, y3
   * with x1, y1 determining the tangent directions.
   * After this, x3, y3 will be the new current point.
   * Note: Two points and their tangents do not determine
   * a unique ellipse, so GSK just picks one. If you need more
   * precise control, use [Gsk.PathBuilder.conicTo]
   * or [Gsk.PathBuilder.svgArcTo].
   * <picture>
   * <source srcset\="arc-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Arc To" src\="arc-light.png">
   * </picture>
   * Params:
   *   x1 = x coordinate of first control point
   *   y1 = y coordinate of first control point
   *   x2 = x coordinate of second control point
   *   y2 = y coordinate of second control point
   */
  void arcTo(float x1, float y1, float x2, float y2)
  {
    gsk_path_builder_arc_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2);
  }

  /**
   * Ends the current contour with a line back to the start point.
   * Note that this is different from calling [Gsk.PathBuilder.lineTo]
   * with the start point in that the contour will be closed. A closed
   * contour behaves differently from an open one. When stroking, its
   * start and end point are considered connected, so they will be
   * joined via the line join, and not ended with line caps.
   */
  void close()
  {
    gsk_path_builder_close(cast(GskPathBuilder*)cPtr);
  }

  /**
   * Adds a [conic curve](https://en.wikipedia.org/wiki/Non-uniform_rational_B-spline)
   * from the current point to x2, y2 with the given weight and x1, y1 as the
   * control point.
   * The weight determines how strongly the curve is pulled towards the control point.
   * A conic with weight 1 is identical to a quadratic Bézier curve with the same points.
   * Conic curves can be used to draw ellipses and circles. They are also known as
   * rational quadratic Bézier curves.
   * After this, x2, y2 will be the new current point.
   * <picture>
   * <source srcset\="conic-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Conic To" src\="conic-light.png">
   * </picture>
   * Params:
   *   x1 = x coordinate of control point
   *   y1 = y coordinate of control point
   *   x2 = x coordinate of the end of the curve
   *   y2 = y coordinate of the end of the curve
   *   weight = weight of the control point, must be greater than zero
   */
  void conicTo(float x1, float y1, float x2, float y2, float weight)
  {
    gsk_path_builder_conic_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2, weight);
  }

  /**
   * Adds a [cubic Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve)
   * from the current point to x3, y3 with x1, y1 and x2, y2 as the control
   * points.
   * After this, x3, y3 will be the new current point.
   * <picture>
   * <source srcset\="cubic-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Cubic To" src\="cubic-light.png">
   * </picture>
   * Params:
   *   x1 = x coordinate of first control point
   *   y1 = y coordinate of first control point
   *   x2 = x coordinate of second control point
   *   y2 = y coordinate of second control point
   *   x3 = x coordinate of the end of the curve
   *   y3 = y coordinate of the end of the curve
   */
  void cubicTo(float x1, float y1, float x2, float y2, float x3, float y3)
  {
    gsk_path_builder_cubic_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2, x3, y3);
  }

  /**
   * Gets the current point.
   * The current point is used for relative drawing commands and
   * updated after every operation.
   * When the builder is created, the default current point is set
   * to `0, 0`. Note that this is different from cairo, which starts
   * out without a current point.
   * Returns: The current point
   */
  Point getCurrentPoint()
  {
    const(graphene_point_t)* _cretval;
    _cretval = gsk_path_builder_get_current_point(cast(GskPathBuilder*)cPtr);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Implements arc-to according to the HTML Canvas spec.
   * A convenience function that implements the
   * [HTML arc_to](https://html.spec.whatwg.org/multipage/canvas.html#dom-context-2d-arcto-dev)
   * functionality.
   * After this, the current point will be the point where
   * the circle with the given radius touches the line from
   * x1, y1 to x2, y2.
   * Params:
   *   x1 = X coordinate of first control point
   *   y1 = Y coordinate of first control point
   *   x2 = X coordinate of second control point
   *   y2 = Y coordinate of second control point
   *   radius = Radius of the circle
   */
  void htmlArcTo(float x1, float y1, float x2, float y2, float radius)
  {
    gsk_path_builder_html_arc_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2, radius);
  }

  /**
   * Draws a line from the current point to x, y and makes it
   * the new current point.
   * <picture>
   * <source srcset\="line-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Line To" src\="line-light.png">
   * </picture>
   * Params:
   *   x = x coordinate
   *   y = y coordinate
   */
  void lineTo(float x, float y)
  {
    gsk_path_builder_line_to(cast(GskPathBuilder*)cPtr, x, y);
  }

  /**
   * Starts a new contour by placing the pen at x, y.
   * If this function is called twice in succession, the first
   * call will result in a contour made up of a single point.
   * The second call will start a new contour.
   * Params:
   *   x = x coordinate
   *   y = y coordinate
   */
  void moveTo(float x, float y)
  {
    gsk_path_builder_move_to(cast(GskPathBuilder*)cPtr, x, y);
  }

  /**
   * Adds a [quadratic Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve)
   * from the current point to x2, y2 with x1, y1 as the control point.
   * After this, x2, y2 will be the new current point.
   * <picture>
   * <source srcset\="quad-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Quad To" src\="quad-light.png">
   * </picture>
   * Params:
   *   x1 = x coordinate of control point
   *   y1 = y coordinate of control point
   *   x2 = x coordinate of the end of the curve
   *   y2 = y coordinate of the end of the curve
   */
  void quadTo(float x1, float y1, float x2, float y2)
  {
    gsk_path_builder_quad_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2);
  }

  /**
   * Adds an elliptical arc from the current point to x3, y3
   * with x1, y1 determining the tangent directions.
   * All coordinates are given relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.arcTo].
   * Params:
   *   x1 = x coordinate of first control point
   *   y1 = y coordinate of first control point
   *   x2 = x coordinate of second control point
   *   y2 = y coordinate of second control point
   */
  void relArcTo(float x1, float y1, float x2, float y2)
  {
    gsk_path_builder_rel_arc_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2);
  }

  /**
   * Adds a [conic curve](https://en.wikipedia.org/wiki/Non-uniform_rational_B-spline)
   * from the current point to x2, y2 with the given weight and x1, y1 as the
   * control point.
   * All coordinates are given relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.conicTo].
   * Params:
   *   x1 = x offset of control point
   *   y1 = y offset of control point
   *   x2 = x offset of the end of the curve
   *   y2 = y offset of the end of the curve
   *   weight = weight of the curve, must be greater than zero
   */
  void relConicTo(float x1, float y1, float x2, float y2, float weight)
  {
    gsk_path_builder_rel_conic_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2, weight);
  }

  /**
   * Adds a [cubic Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve)
   * from the current point to x3, y3 with x1, y1 and x2, y2 as the control
   * points.
   * All coordinates are given relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.cubicTo].
   * Params:
   *   x1 = x offset of first control point
   *   y1 = y offset of first control point
   *   x2 = x offset of second control point
   *   y2 = y offset of second control point
   *   x3 = x offset of the end of the curve
   *   y3 = y offset of the end of the curve
   */
  void relCubicTo(float x1, float y1, float x2, float y2, float x3, float y3)
  {
    gsk_path_builder_rel_cubic_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2, x3, y3);
  }

  /**
   * Implements arc-to according to the HTML Canvas spec.
   * All coordinates are given relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.htmlArcTo].
   * Params:
   *   x1 = X coordinate of first control point
   *   y1 = Y coordinate of first control point
   *   x2 = X coordinate of second control point
   *   y2 = Y coordinate of second control point
   *   radius = Radius of the circle
   */
  void relHtmlArcTo(float x1, float y1, float x2, float y2, float radius)
  {
    gsk_path_builder_rel_html_arc_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2, radius);
  }

  /**
   * Draws a line from the current point to a point offset from it
   * by x, y and makes it the new current point.
   * This is the relative version of [Gsk.PathBuilder.lineTo].
   * Params:
   *   x = x offset
   *   y = y offset
   */
  void relLineTo(float x, float y)
  {
    gsk_path_builder_rel_line_to(cast(GskPathBuilder*)cPtr, x, y);
  }

  /**
   * Starts a new contour by placing the pen at x, y
   * relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.moveTo].
   * Params:
   *   x = x offset
   *   y = y offset
   */
  void relMoveTo(float x, float y)
  {
    gsk_path_builder_rel_move_to(cast(GskPathBuilder*)cPtr, x, y);
  }

  /**
   * Adds a [quadratic Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve)
   * from the current point to x2, y2 with x1, y1 the control point.
   * All coordinates are given relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.quadTo].
   * Params:
   *   x1 = x offset of control point
   *   y1 = y offset of control point
   *   x2 = x offset of the end of the curve
   *   y2 = y offset of the end of the curve
   */
  void relQuadTo(float x1, float y1, float x2, float y2)
  {
    gsk_path_builder_rel_quad_to(cast(GskPathBuilder*)cPtr, x1, y1, x2, y2);
  }

  /**
   * Implements arc-to according to the SVG spec.
   * All coordinates are given relative to the current point.
   * This is the relative version of [Gsk.PathBuilder.svgArcTo].
   * Params:
   *   rx = X radius
   *   ry = Y radius
   *   xAxisRotation = the rotation of the ellipsis
   *   largeArc = whether to add the large arc
   *   positiveSweep = whether to sweep in the positive direction
   *   x = the X coordinate of the endpoint
   *   y = the Y coordinate of the endpoint
   */
  void relSvgArcTo(float rx, float ry, float xAxisRotation, bool largeArc, bool positiveSweep, float x, float y)
  {
    gsk_path_builder_rel_svg_arc_to(cast(GskPathBuilder*)cPtr, rx, ry, xAxisRotation, largeArc, positiveSweep, x, y);
  }

  /**
   * Implements arc-to according to the SVG spec.
   * A convenience function that implements the
   * [SVG arc_to](https://www.w3.org/TR/SVG11/paths.html#PathDataEllipticalArcCommands)
   * functionality.
   * After this, x, y will be the new current point.
   * Params:
   *   rx = X radius
   *   ry = Y radius
   *   xAxisRotation = the rotation of the ellipsis
   *   largeArc = whether to add the large arc
   *   positiveSweep = whether to sweep in the positive direction
   *   x = the X coordinate of the endpoint
   *   y = the Y coordinate of the endpoint
   */
  void svgArcTo(float rx, float ry, float xAxisRotation, bool largeArc, bool positiveSweep, float x, float y)
  {
    gsk_path_builder_svg_arc_to(cast(GskPathBuilder*)cPtr, rx, ry, xAxisRotation, largeArc, positiveSweep, x, y);
  }

  /**
   * Creates a new `GskPath` from the given builder.
   * The given `GskPathBuilder` is reset once this function returns;
   * you cannot call this function multiple times on the same builder
   * instance.
   * This function is intended primarily for language bindings.
   * C code should use [Gsk.PathBuilder.freeToPath].
   * Returns: the newly created `GskPath`
   *   with all the contours added to the builder
   */
  DGskPath toPath()
  {
    GskPath* _cretval;
    _cretval = gsk_path_builder_to_path(cast(GskPathBuilder*)cPtr);
    auto _retval = _cretval ? new DGskPath(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
