module cairo.Pattern;

import GLib.Boxed;
import Gid.gid;
import cairo.Matrix;
import cairo.Surface;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A #cairo_pattern_t represents a source when drawing onto a
 * surface. There are different subtypes of #cairo_pattern_t,
 * for different types of sources; for example,
 * [cairo.Global.patternCreateRgb] creates a pattern for a solid
 * opaque color.
 * Other than various
 * <function>cairo_pattern_create_<emphasis>type</emphasis>$(LPAREN)$(RPAREN)</function>
 * functions, some of the pattern types can be implicitly created using various
 * <function>cairo_set_source_<emphasis>type</emphasis>$(LPAREN)$(RPAREN)</function> functions;
 * for example [cairo.Context.setSourceRgb].
 * The type of a pattern can be queried with [cairo.Pattern.getPatternType].
 * Memory management of #cairo_pattern_t is done with
 * [cairo.Pattern.reference] and [cairo.Pattern.destroy].
 */
class Pattern : Boxed
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
    return cairo_gobject_pattern_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Adds an opaque color stop to a gradient pattern. The offset
   * specifies the location along the gradient's control vector. For
   * example, a linear gradient's control vector is from $(LPAREN)x0,y0$(RPAREN) to
   * $(LPAREN)x1,y1$(RPAREN) while a radial gradient's control vector is from any point
   * on the start circle to the corresponding point on the end circle.
   * The color is specified in the same way as in [cairo.Context.setSourceRgb].
   * If two $(LPAREN)or more$(RPAREN) stops are specified with identical offset values,
   * they will be sorted according to the order in which the stops are
   * added, $(LPAREN)stops added earlier will compare less than stops added
   * later$(RPAREN). This can be useful for reliably making sharp color
   * transitions instead of the typical blend.
   * Note: If the pattern is not a gradient pattern, $(LPAREN)eg. a linear or
   * radial pattern$(RPAREN), then the pattern will be put into an error status
   * with a status of %CAIRO_STATUS_PATTERN_TYPE_MISMATCH.
   * Params:
   *   offset = an offset in the range [0.0 .. 1.0]
   *   red = red component of color
   *   green = green component of color
   *   blue = blue component of color
   */
  void addColorStopRgb(double offset, double red, double green, double blue)
  {
    cairo_pattern_add_color_stop_rgb(cast(cairo_pattern_t*)cPtr, offset, red, green, blue);
  }

  /**
   * Adds a translucent color stop to a gradient pattern. The offset
   * specifies the location along the gradient's control vector. For
   * example, a linear gradient's control vector is from $(LPAREN)x0,y0$(RPAREN) to
   * $(LPAREN)x1,y1$(RPAREN) while a radial gradient's control vector is from any point
   * on the start circle to the corresponding point on the end circle.
   * The color is specified in the same way as in [cairo.Context.setSourceRgba].
   * If two $(LPAREN)or more$(RPAREN) stops are specified with identical offset values,
   * they will be sorted according to the order in which the stops are
   * added, $(LPAREN)stops added earlier will compare less than stops added
   * later$(RPAREN). This can be useful for reliably making sharp color
   * transitions instead of the typical blend.
   * Note: If the pattern is not a gradient pattern, $(LPAREN)eg. a linear or
   * radial pattern$(RPAREN), then the pattern will be put into an error status
   * with a status of %CAIRO_STATUS_PATTERN_TYPE_MISMATCH.
   * Params:
   *   offset = an offset in the range [0.0 .. 1.0]
   *   red = red component of color
   *   green = green component of color
   *   blue = blue component of color
   *   alpha = alpha component of color
   */
  void addColorStopRgba(double offset, double red, double green, double blue, double alpha)
  {
    cairo_pattern_add_color_stop_rgba(cast(cairo_pattern_t*)cPtr, offset, red, green, blue, alpha);
  }

  /**
   * Gets the number of color stops specified in the given gradient
   * pattern.
   * Params:
   *   count = return value for the number of color stops, or %NULL
   * Returns: %CAIRO_STATUS_SUCCESS, or
   *   %CAIRO_STATUS_PATTERN_TYPE_MISMATCH if pattern is not a gradient
   *   pattern.
   */
  Status getColorStopCount(out int count)
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_get_color_stop_count(cast(cairo_pattern_t*)cPtr, cast(int*)&count);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Gets the color and offset information at the given index for a
   * gradient pattern.  Values of index range from 0 to n-1
   * where n is the number returned
   * by [cairo.Pattern.getColorStopCount].
   * Note that the color and alpha values are not premultiplied.
   * Params:
   *   index = index of the stop to return data for
   *   offset = return value for the offset of the stop, or %NULL
   *   red = return value for red component of color, or %NULL
   *   green = return value for green component of color, or %NULL
   *   blue = return value for blue component of color, or %NULL
   *   alpha = return value for alpha component of color, or %NULL
   * Returns: %CAIRO_STATUS_SUCCESS, or %CAIRO_STATUS_INVALID_INDEX
   *   if index is not valid for the given pattern.  If the pattern is
   *   not a gradient pattern, %CAIRO_STATUS_PATTERN_TYPE_MISMATCH is
   *   returned.
   */
  Status getColorStopRgba(int index, out double offset, out double red, out double green, out double blue, out double alpha)
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_get_color_stop_rgba(cast(cairo_pattern_t*)cPtr, index, cast(double*)&offset, cast(double*)&red, cast(double*)&green, cast(double*)&blue, cast(double*)&alpha);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Gets the current dithering mode, as set by
   * [cairo.Pattern.setDither].
   * Returns: the current dithering mode.
   */
  Dither getDither()
  {
    cairo_dither_t _cretval;
    _cretval = cairo_pattern_get_dither(cast(cairo_pattern_t*)cPtr);
    Dither _retval = cast(Dither)_cretval;
    return _retval;
  }

  /**
   * Gets the current extend mode for a pattern.  See #cairo_extend_t
   * for details on the semantics of each extend strategy.
   * Returns: the current extend strategy used for drawing the
   *   pattern.
   */
  Extend getExtend()
  {
    cairo_extend_t _cretval;
    _cretval = cairo_pattern_get_extend(cast(cairo_pattern_t*)cPtr);
    Extend _retval = cast(Extend)_cretval;
    return _retval;
  }

  /**
   * Gets the current filter for a pattern.  See #cairo_filter_t
   * for details on each filter.
   * Returns: the current filter used for resizing the pattern.
   */
  Filter getFilter()
  {
    cairo_filter_t _cretval;
    _cretval = cairo_pattern_get_filter(cast(cairo_pattern_t*)cPtr);
    Filter _retval = cast(Filter)_cretval;
    return _retval;
  }

  /**
   * Gets the gradient endpoints for a linear gradient.
   * Params:
   *   x0 = return value for the x coordinate of the first point, or %NULL
   *   y0 = return value for the y coordinate of the first point, or %NULL
   *   x1 = return value for the x coordinate of the second point, or %NULL
   *   y1 = return value for the y coordinate of the second point, or %NULL
   * Returns: %CAIRO_STATUS_SUCCESS, or
   *   %CAIRO_STATUS_PATTERN_TYPE_MISMATCH if pattern is not a linear
   *   gradient pattern.
   */
  Status getLinearPoints(out double x0, out double y0, out double x1, out double y1)
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_get_linear_points(cast(cairo_pattern_t*)cPtr, cast(double*)&x0, cast(double*)&y0, cast(double*)&x1, cast(double*)&y1);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Stores the pattern's transformation matrix into matrix.
   * Params:
   *   matrix = return value for the matrix
   */
  void getMatrix(Matrix matrix)
  {
    cairo_pattern_get_matrix(cast(cairo_pattern_t*)cPtr, matrix ? cast(cairo_matrix_t*)matrix.cPtr(false) : null);
  }

  /**
   * Gets the gradient endpoint circles for a radial gradient, each
   * specified as a center coordinate and a radius.
   * Params:
   *   x0 = return value for the x coordinate of the center of the first circle, or %NULL
   *   y0 = return value for the y coordinate of the center of the first circle, or %NULL
   *   r0 = return value for the radius of the first circle, or %NULL
   *   x1 = return value for the x coordinate of the center of the second circle, or %NULL
   *   y1 = return value for the y coordinate of the center of the second circle, or %NULL
   *   r1 = return value for the radius of the second circle, or %NULL
   * Returns: %CAIRO_STATUS_SUCCESS, or
   *   %CAIRO_STATUS_PATTERN_TYPE_MISMATCH if pattern is not a radial
   *   gradient pattern.
   */
  Status getRadialCircles(out double x0, out double y0, out double r0, out double x1, out double y1, out double r1)
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_get_radial_circles(cast(cairo_pattern_t*)cPtr, cast(double*)&x0, cast(double*)&y0, cast(double*)&r0, cast(double*)&x1, cast(double*)&y1, cast(double*)&r1);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Gets the solid color for a solid color pattern.
   * Note that the color and alpha values are not premultiplied.
   * Params:
   *   red = return value for red component of color, or %NULL
   *   green = return value for green component of color, or %NULL
   *   blue = return value for blue component of color, or %NULL
   *   alpha = return value for alpha component of color, or %NULL
   * Returns: %CAIRO_STATUS_SUCCESS, or
   *   %CAIRO_STATUS_PATTERN_TYPE_MISMATCH if the pattern is not a solid
   *   color pattern.
   */
  Status getRgba(out double red, out double green, out double blue, out double alpha)
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_get_rgba(cast(cairo_pattern_t*)cPtr, cast(double*)&red, cast(double*)&green, cast(double*)&blue, cast(double*)&alpha);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Gets the surface of a surface pattern.  The reference returned in
   * surface is owned by the pattern; the caller should call
   * [cairo.Surface.reference] if the surface is to be retained.
   * Params:
   *   surface = return value for surface of pattern, or %NULL
   * Returns: %CAIRO_STATUS_SUCCESS, or
   *   %CAIRO_STATUS_PATTERN_TYPE_MISMATCH if the pattern is not a surface
   *   pattern.
   */
  Status getSurface(Surface surface)
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_get_surface(cast(cairo_pattern_t*)cPtr, surface ? cast(cairo_surface_t**)surface.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Get the pattern's type.  See #cairo_pattern_type_t for available
   * types.
   * Returns: The type of pattern.
   */
  PatternType getPatternType()
  {
    cairo_pattern_type_t _cretval;
    _cretval = cairo_pattern_get_type(cast(cairo_pattern_t*)cPtr);
    PatternType _retval = cast(PatternType)_cretval;
    return _retval;
  }

  /**
   * Return user data previously attached to pattern using the
   * specified key.  If no user data has been attached with the given
   * key this function returns %NULL.
   * Params:
   *   key = the address of the #cairo_user_data_key_t the user data was
   *     attached to
   * Returns: the user data previously attached or %NULL.
   */
  void* getUserData(UserDataKey key)
  {
    void* _retval;
    _retval = cairo_pattern_get_user_data(cast(cairo_pattern_t*)cPtr, &key);
    return _retval;
  }

  /**
   * Set the dithering mode of the rasterizer used for drawing shapes.
   * This value is a hint, and a particular backend may or may not support
   * a particular value.  At the current time, only pixman is supported.
   * Params:
   *   dither = a #cairo_dither_t describing the new dithering mode
   */
  void setDither(Dither dither)
  {
    cairo_pattern_set_dither(cast(cairo_pattern_t*)cPtr, dither);
  }

  /**
   * Sets the mode to be used for drawing outside the area of a pattern.
   * See #cairo_extend_t for details on the semantics of each extend
   * strategy.
   * The default extend mode is %CAIRO_EXTEND_NONE for surface patterns
   * and %CAIRO_EXTEND_PAD for gradient patterns.
   * Params:
   *   extend = a #cairo_extend_t describing how the area outside of the
   *     pattern will be drawn
   */
  void setExtend(Extend extend)
  {
    cairo_pattern_set_extend(cast(cairo_pattern_t*)cPtr, extend);
  }

  /**
   * Sets the filter to be used for resizing when using this pattern.
   * See #cairo_filter_t for details on each filter.
   * * Note that you might want to control filtering even when you do not
   * have an explicit #cairo_pattern_t object, $(LPAREN)for example when using
   * [cairo.Context.setSourceSurface]$(RPAREN). In these cases, it is convenient to
   * use [cairo.Context.getSource] to get access to the pattern that cairo
   * creates implicitly. For example:
   * <informalexample><programlisting>
   * cairo_set_source_surface $(LPAREN)cr, image, x, y$(RPAREN);
   * cairo_pattern_set_filter $(LPAREN)cairo_get_source $(LPAREN)cr$(RPAREN), CAIRO_FILTER_NEAREST$(RPAREN);
   * </programlisting></informalexample>
   * Params:
   *   filter = a #cairo_filter_t describing the filter to use for resizing
   *     the pattern
   */
  void setFilter(Filter filter)
  {
    cairo_pattern_set_filter(cast(cairo_pattern_t*)cPtr, filter);
  }

  /**
   * Sets the pattern's transformation matrix to matrix. This matrix is
   * a transformation from user space to pattern space.
   * When a pattern is first created it always has the identity matrix
   * for its transformation matrix, which means that pattern space is
   * initially identical to user space.
   * Important: Please note that the direction of this transformation
   * matrix is from user space to pattern space. This means that if you
   * imagine the flow from a pattern to user space $(LPAREN)and on to device
   * space$(RPAREN), then coordinates in that flow will be transformed by the
   * inverse of the pattern matrix.
   * For example, if you want to make a pattern appear twice as large as
   * it does by default the correct code to use is:
   * <informalexample><programlisting>
   * cairo_matrix_init_scale $(LPAREN)&amp;matrix, 0.5, 0.5$(RPAREN);
   * cairo_pattern_set_matrix $(LPAREN)pattern, &amp;matrix$(RPAREN);
   * </programlisting></informalexample>
   * Meanwhile, using values of 2.0 rather than 0.5 in the code above
   * would cause the pattern to appear at half of its default size.
   * Also, please note the discussion of the user-space locking
   * semantics of [cairo.Context.setSource].
   * Params:
   *   matrix = a #cairo_matrix_t
   */
  void setMatrix(Matrix matrix)
  {
    cairo_pattern_set_matrix(cast(cairo_pattern_t*)cPtr, matrix ? cast(cairo_matrix_t*)matrix.cPtr(false) : null);
  }

  /**
   * Checks whether an error has previously occurred for this
   * pattern.
   * Returns: %CAIRO_STATUS_SUCCESS, %CAIRO_STATUS_NO_MEMORY,
   *   %CAIRO_STATUS_INVALID_MATRIX, %CAIRO_STATUS_PATTERN_TYPE_MISMATCH,
   *   or %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
   */
  Status status()
  {
    cairo_status_t _cretval;
    _cretval = cairo_pattern_status(cast(cairo_pattern_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }
}
