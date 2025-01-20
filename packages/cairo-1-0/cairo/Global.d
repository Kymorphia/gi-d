module cairo.Global;

import Gid.gid;
import cairo.Context;
import cairo.Device;
import cairo.FontFace;
import cairo.FontOptions;
import cairo.Glyph;
import cairo.Matrix;
import cairo.Path;
import cairo.Pattern;
import cairo.Rectangle;
import cairo.RectangleInt;
import cairo.Region;
import cairo.ScaledFont;
import cairo.Surface;
import cairo.TextCluster;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;


/**
 * Creates a new #cairo_t with all graphics state parameters set to
 * default values and with target as a target surface. The target
 * surface should be constructed with a backend-specific function such
 * as [cairo.Global.imageSurfaceCreate] $(LPAREN)or any other
 * <function>cairo_<emphasis>backend</emphasis>_surface_create$(LPAREN)<!-- -->$(RPAREN)</function>
 * variant$(RPAREN).
 * This function references target, so you can immediately
 * call [cairo.Surface.destroy] on it if you don't need to
 * maintain a separate reference to it.
 * Params:
 *   target = target surface for the context
 * Returns: a newly allocated #cairo_t with a reference
 *   count of 1. The initial reference count should be released
 *   with [cairo.Global.destroy] when you are done using the #cairo_t.
 *   This function never returns %NULL. If memory cannot be
 *   allocated, a special #cairo_t object will be returned on
 *   which [cairo.Context.status] returns %CAIRO_STATUS_NO_MEMORY. If
 *   you attempt to target a surface which does not support
 *   writing $(LPAREN)such as #cairo_mime_surface_t$(RPAREN) then a
 *   %CAIRO_STATUS_WRITE_ERROR will be raised.  You can use this
 *   object normally, but no drawing will be done.
 */
Context create(Surface target)
{
  cairo_t* _cretval;
  _cretval = cairo_create(target ? cast(cairo_surface_t*)target.cPtr(false) : null);
  auto _retval = _cretval ? new Context(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Resets all static data within cairo to its original state,
 * $(LPAREN)ie. identical to the state at the time of program invocation$(RPAREN). For
 * example, all caches within cairo will be flushed empty.
 * This function is intended to be useful when using memory-checking
 * tools such as valgrind. When valgrind's memcheck analyzes a
 * cairo-using program without a call to [cairo.Global.debugResetStaticData],
 * it will report all data reachable via cairo's static objects as
 * "still reachable". Calling [cairo.Global.debugResetStaticData] just prior
 * to program termination will make it easier to get squeaky clean
 * reports from valgrind.
 * WARNING: It is only safe to call this function when there are no
 * active cairo objects remaining, $(LPAREN)ie. the appropriate destroy
 * functions have been called as necessary$(RPAREN). If there are active cairo
 * objects, this call is likely to cause a crash, $(LPAREN)eg. an assertion
 * failure due to a hash table being destroyed when non-empty$(RPAREN).
 */
void debugResetStaticData()
{
  cairo_debug_reset_static_data();
}

/**
 * Allocates a new font options object with all options initialized
 * to default values.
 * Returns: a newly allocated #cairo_font_options_t. Free with
 *   [cairo.FontOptions.destroy]. This function always returns a
 *   valid pointer; if memory cannot be allocated, then a special
 *   error object is returned where all operations on the object do nothing.
 *   You can check for this with [cairo.FontOptions.status].
 */
FontOptions fontOptionsCreate()
{
  cairo_font_options_t* _cretval;
  _cretval = cairo_font_options_create();
  auto _retval = _cretval ? new FontOptions(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * This function provides a stride value that will respect all
 * alignment requirements of the accelerated image-rendering code
 * within cairo. Typical usage will be of the form:
 * <informalexample><programlisting>
 * int stride;
 * unsigned char *data;
 * cairo_surface_t *surface;
 * stride \= cairo_format_stride_for_width $(LPAREN)format, width$(RPAREN);
 * data \= malloc $(LPAREN)stride * height$(RPAREN);
 * surface \= cairo_image_surface_create_for_data $(LPAREN)data, format,
 * width, height,
 * stride$(RPAREN);
 * </programlisting></informalexample>
 * Params:
 *   format = A #cairo_format_t value
 *   width = The desired width of an image surface to be created.
 * Returns: the appropriate stride to use given the desired
 *   format and width, or -1 if either the format is invalid or the width
 *   too large.
 */
int formatStrideForWidth(Format format, int width)
{
  int _retval;
  _retval = cairo_format_stride_for_width(format, width);
  return _retval;
}

/**
 * Return user data previously attached to cr using the specified
 * key.  If no user data has been attached with the given key this
 * function returns %NULL.
 * Params:
 *   cr = a #cairo_t
 *   key = the address of the #cairo_user_data_key_t the user data was
 *     attached to
 * Returns: the user data previously attached or %NULL.
 */
void* getUserData(Context cr, UserDataKey key)
{
  void* _retval;
  _retval = cairo_get_user_data(cr ? cast(cairo_t*)cr.cPtr(false) : null, &key);
  return _retval;
}

/**
 * Allocates an array of #cairo_glyph_t's.
 * This function is only useful in implementations of
 * #cairo_user_scaled_font_text_to_glyphs_func_t where the user
 * needs to allocate an array of glyphs that cairo will free.
 * For all other uses, user can use their own allocation method
 * for glyphs.
 * This function returns %NULL if num_glyphs is not positive,
 * or if out of memory.  That means, the %NULL return value
 * signals out-of-memory only if num_glyphs was positive.
 * Params:
 *   numGlyphs = number of glyphs to allocate
 * Returns: the newly allocated array of glyphs that should be
 *   freed using [cairo.Glyph.free]
 */
Glyph glyphAllocate(int numGlyphs)
{
  cairo_glyph_t* _cretval;
  _cretval = cairo_glyph_allocate(numGlyphs);
  auto _retval = _cretval ? new Glyph(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates an image surface of the specified format and
 * dimensions. Initially the surface contents are set to 0.
 * $(LPAREN)Specifically, within each pixel, each color or alpha channel
 * belonging to format will be 0. The contents of bits within a pixel,
 * but not belonging to the given format are undefined$(RPAREN).
 * Params:
 *   format = format of pixels in the surface to create
 *   width = width of the surface, in pixels
 *   height = height of the surface, in pixels
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" surface if an error such as out of memory
 *   occurs. You can use [cairo.Surface.status] to check for this.
 */
Surface imageSurfaceCreate(Format format, int width, int height)
{
  cairo_surface_t* _cretval;
  _cretval = cairo_image_surface_create(format, width, height);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new image surface and initializes the contents to the
 * given PNG file.
 * Params:
 *   filename = name of PNG file to load. On Windows this filename
 *     is encoded in UTF-8.
 * Returns: a new #cairo_surface_t initialized with the contents
 *   of the PNG file, or a "nil" surface if any error occurred. A nil
 *   surface can be checked for with cairo_surface_status$(LPAREN)surface$(RPAREN) which
 *   may return one of the following values:
 *   %CAIRO_STATUS_NO_MEMORY
 *   %CAIRO_STATUS_FILE_NOT_FOUND
 *   %CAIRO_STATUS_READ_ERROR
 *   %CAIRO_STATUS_PNG_ERROR
 *   Alternatively, you can allow errors to propagate through the drawing
 *   operations and check the status on the context upon completion
 *   using [cairo.Context.status].
 */
Surface imageSurfaceCreateFromPng(string filename)
{
  cairo_surface_t* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = cairo_image_surface_create_from_png(_filename);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Get the format of the surface.
 * Params:
 *   surface = a #cairo_image_surface_t
 * Returns: the format of the surface
 */
Format imageSurfaceGetFormat(Surface surface)
{
  cairo_format_t _cretval;
  _cretval = cairo_image_surface_get_format(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  Format _retval = cast(Format)_cretval;
  return _retval;
}

/**
 * Get the height of the image surface in pixels.
 * Params:
 *   surface = a #cairo_image_surface_t
 * Returns: the height of the surface in pixels.
 */
int imageSurfaceGetHeight(Surface surface)
{
  int _retval;
  _retval = cairo_image_surface_get_height(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  return _retval;
}

/**
 * Get the stride of the image surface in bytes
 * Params:
 *   surface = a #cairo_image_surface_t
 * Returns: the stride of the image surface in bytes $(LPAREN)or 0 if
 *   surface is not an image surface$(RPAREN). The stride is the distance in
 *   bytes from the beginning of one row of the image data to the
 *   beginning of the next row.
 */
int imageSurfaceGetStride(Surface surface)
{
  int _retval;
  _retval = cairo_image_surface_get_stride(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  return _retval;
}

/**
 * Get the width of the image surface in pixels.
 * Params:
 *   surface = a #cairo_image_surface_t
 * Returns: the width of the surface in pixels.
 */
int imageSurfaceGetWidth(Surface surface)
{
  int _retval;
  _retval = cairo_image_surface_get_width(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  return _retval;
}

/**
 * Begin a patch in a mesh pattern.
 * After calling this function, the patch shape should be defined with
 * [cairo.Global.meshPatternMoveTo], [cairo.Global.meshPatternLineTo] and
 * [cairo.Global.meshPatternCurveTo].
 * After defining the patch, [cairo.Global.meshPatternEndPatch] must be
 * called before using pattern as a source or mask.
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If pattern already has a
 * current patch, it will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 */
void meshPatternBeginPatch(Pattern pattern)
{
  cairo_mesh_pattern_begin_patch(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null);
}

/**
 * Adds a cubic Bézier spline to the current patch from the current
 * point to position $(LPAREN)x3, y3$(RPAREN) in pattern-space coordinates, using
 * $(LPAREN)x1, y1$(RPAREN) and $(LPAREN)x2, y2$(RPAREN) as the control points.
 * If the current patch has no current point before the call to
 * [cairo.Global.meshPatternCurveTo], this function will behave as if
 * preceded by a call to cairo_mesh_pattern_move_to$(LPAREN)pattern, x1,
 * y1$(RPAREN).
 * After this call the current point will be $(LPAREN)x3, y3$(RPAREN).
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If pattern has no current
 * patch or the current patch already has 4 sides, pattern will be
 * put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   x1 = the X coordinate of the first control point
 *   y1 = the Y coordinate of the first control point
 *   x2 = the X coordinate of the second control point
 *   y2 = the Y coordinate of the second control point
 *   x3 = the X coordinate of the end of the curve
 *   y3 = the Y coordinate of the end of the curve
 */
void meshPatternCurveTo(Pattern pattern, double x1, double y1, double x2, double y2, double x3, double y3)
{
  cairo_mesh_pattern_curve_to(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, x1, y1, x2, y2, x3, y3);
}

/**
 * Indicates the end of the current patch in a mesh pattern.
 * If the current patch has less than 4 sides, it is closed with a
 * straight line from the current point to the first point of the
 * patch as if [cairo.Global.meshPatternLineTo] was used.
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If pattern has no current
 * patch or the current patch has no current point, pattern will be
 * put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 */
void meshPatternEndPatch(Pattern pattern)
{
  cairo_mesh_pattern_end_patch(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null);
}

/**
 * Gets the control point point_num of patch patch_num for a mesh
 * pattern.
 * patch_num can range from 0 to n-1 where n is the number returned by
 * [cairo.Global.meshPatternGetPatchCount].
 * Valid values for point_num are from 0 to 3 and identify the
 * control points as explained in [cairo.Global.patternCreateMesh].
 * Params:
 *   pattern = a #cairo_pattern_t
 *   patchNum = the patch number to return data for
 *   pointNum = the control point number to return data for
 *   x = return value for the x coordinate of the control point, or %NULL
 *   y = return value for the y coordinate of the control point, or %NULL
 * Returns: %CAIRO_STATUS_SUCCESS, or %CAIRO_STATUS_INVALID_INDEX
 *   if patch_num or point_num is not valid for pattern. If pattern
 *   is not a mesh pattern, %CAIRO_STATUS_PATTERN_TYPE_MISMATCH is
 *   returned.
 */
Status meshPatternGetControlPoint(Pattern pattern, uint patchNum, uint pointNum, out double x, out double y)
{
  cairo_status_t _cretval;
  _cretval = cairo_mesh_pattern_get_control_point(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, patchNum, pointNum, cast(double*)&x, cast(double*)&y);
  Status _retval = cast(Status)_cretval;
  return _retval;
}

/**
 * Gets the color information in corner corner_num of patch
 * patch_num for a mesh pattern.
 * patch_num can range from 0 to n-1 where n is the number returned by
 * [cairo.Global.meshPatternGetPatchCount].
 * Valid values for corner_num are from 0 to 3 and identify the
 * corners as explained in [cairo.Global.patternCreateMesh].
 * Note that the color and alpha values are not premultiplied.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   patchNum = the patch number to return data for
 *   cornerNum = the corner number to return data for
 *   red = return value for red component of color, or %NULL
 *   green = return value for green component of color, or %NULL
 *   blue = return value for blue component of color, or %NULL
 *   alpha = return value for alpha component of color, or %NULL
 * Returns: %CAIRO_STATUS_SUCCESS, or %CAIRO_STATUS_INVALID_INDEX
 *   if patch_num or corner_num is not valid for pattern. If
 *   pattern is not a mesh pattern, %CAIRO_STATUS_PATTERN_TYPE_MISMATCH
 *   is returned.
 */
Status meshPatternGetCornerColorRgba(Pattern pattern, uint patchNum, uint cornerNum, out double red, out double green, out double blue, out double alpha)
{
  cairo_status_t _cretval;
  _cretval = cairo_mesh_pattern_get_corner_color_rgba(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, patchNum, cornerNum, cast(double*)&red, cast(double*)&green, cast(double*)&blue, cast(double*)&alpha);
  Status _retval = cast(Status)_cretval;
  return _retval;
}

/**
 * Gets the number of patches specified in the given mesh pattern.
 * The number only includes patches which have been finished by
 * calling [cairo.Global.meshPatternEndPatch]. For example it will be 0
 * during the definition of the first patch.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   count = return value for the number patches, or %NULL
 * Returns: %CAIRO_STATUS_SUCCESS, or
 *   %CAIRO_STATUS_PATTERN_TYPE_MISMATCH if pattern is not a mesh
 *   pattern.
 */
Status meshPatternGetPatchCount(Pattern pattern, out uint count)
{
  cairo_status_t _cretval;
  _cretval = cairo_mesh_pattern_get_patch_count(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, cast(uint*)&count);
  Status _retval = cast(Status)_cretval;
  return _retval;
}

/**
 * Gets path defining the patch patch_num for a mesh
 * pattern.
 * patch_num can range from 0 to n-1 where n is the number returned by
 * [cairo.Global.meshPatternGetPatchCount].
 * Params:
 *   pattern = a #cairo_pattern_t
 *   patchNum = the patch number to return data for
 * Returns: the path defining the patch, or a path with status
 *   %CAIRO_STATUS_INVALID_INDEX if patch_num or point_num is not
 *   valid for pattern. If pattern is not a mesh pattern, a path with
 *   status %CAIRO_STATUS_PATTERN_TYPE_MISMATCH is returned.
 */
Path meshPatternGetPath(Pattern pattern, uint patchNum)
{
  cairo_path_t* _cretval;
  _cretval = cairo_mesh_pattern_get_path(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, patchNum);
  auto _retval = _cretval ? new Path(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Adds a line to the current patch from the current point to position
 * $(LPAREN)x, y$(RPAREN) in pattern-space coordinates.
 * If there is no current point before the call to
 * [cairo.Global.meshPatternLineTo] this function will behave as
 * cairo_mesh_pattern_move_to$(LPAREN)pattern, x, y$(RPAREN).
 * After this call the current point will be $(LPAREN)x, y$(RPAREN).
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If pattern has no current
 * patch or the current patch already has 4 sides, pattern will be
 * put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   x = the X coordinate of the end of the new line
 *   y = the Y coordinate of the end of the new line
 */
void meshPatternLineTo(Pattern pattern, double x, double y)
{
  cairo_mesh_pattern_line_to(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, x, y);
}

/**
 * Define the first point of the current patch in a mesh pattern.
 * After this call the current point will be $(LPAREN)x, y$(RPAREN).
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If pattern has no current
 * patch or the current patch already has at least one side, pattern
 * will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   x = the X coordinate of the new position
 *   y = the Y coordinate of the new position
 */
void meshPatternMoveTo(Pattern pattern, double x, double y)
{
  cairo_mesh_pattern_move_to(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, x, y);
}

/**
 * Set an internal control point of the current patch.
 * Valid values for point_num are from 0 to 3 and identify the
 * control points as explained in [cairo.Global.patternCreateMesh].
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If point_num is not valid,
 * pattern will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_INDEX.  If pattern has no current patch,
 * pattern will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   pointNum = the control point to set the position for
 *   x = the X coordinate of the control point
 *   y = the Y coordinate of the control point
 */
void meshPatternSetControlPoint(Pattern pattern, uint pointNum, double x, double y)
{
  cairo_mesh_pattern_set_control_point(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, pointNum, x, y);
}

/**
 * Sets the color of a corner of the current patch in a mesh pattern.
 * The color is specified in the same way as in [cairo.Context.setSourceRgb].
 * Valid values for corner_num are from 0 to 3 and identify the
 * corners as explained in [cairo.Global.patternCreateMesh].
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If corner_num is not valid,
 * pattern will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_INDEX.  If pattern has no current patch,
 * pattern will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   cornerNum = the corner to set the color for
 *   red = red component of color
 *   green = green component of color
 *   blue = blue component of color
 */
void meshPatternSetCornerColorRgb(Pattern pattern, uint cornerNum, double red, double green, double blue)
{
  cairo_mesh_pattern_set_corner_color_rgb(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, cornerNum, red, green, blue);
}

/**
 * Sets the color of a corner of the current patch in a mesh pattern.
 * The color is specified in the same way as in [cairo.Context.setSourceRgba].
 * Valid values for corner_num are from 0 to 3 and identify the
 * corners as explained in [cairo.Global.patternCreateMesh].
 * Note: If pattern is not a mesh pattern then pattern will be put
 * into an error status with a status of
 * %CAIRO_STATUS_PATTERN_TYPE_MISMATCH. If corner_num is not valid,
 * pattern will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_INDEX.  If pattern has no current patch,
 * pattern will be put into an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * Params:
 *   pattern = a #cairo_pattern_t
 *   cornerNum = the corner to set the color for
 *   red = red component of color
 *   green = green component of color
 *   blue = blue component of color
 *   alpha = alpha component of color
 */
void meshPatternSetCornerColorRgba(Pattern pattern, uint cornerNum, double red, double green, double blue, double alpha)
{
  cairo_mesh_pattern_set_corner_color_rgba(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, cornerNum, red, green, blue, alpha);
}

/**
 * Create a new #cairo_pattern_t for the given surface.
 * Params:
 *   surface = the surface
 * Returns: the newly created #cairo_pattern_t if successful, or
 *   an error pattern in case of no memory.  The caller owns the
 *   returned object and should call [cairo.Pattern.destroy] when
 *   finished with it.
 *   This function will always return a valid pointer, but if an error
 *   occurred the pattern status will be set to an error.  To inspect
 *   the status of a pattern use [cairo.Pattern.status].
 */
Pattern patternCreateForSurface(Surface surface)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_for_surface(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Create a new linear gradient #cairo_pattern_t along the line defined
 * by $(LPAREN)x0, y0$(RPAREN) and $(LPAREN)x1, y1$(RPAREN).  Before using the gradient pattern, a
 * number of color stops should be defined using
 * [cairo.Pattern.addColorStopRgb] or
 * [cairo.Pattern.addColorStopRgba].
 * Note: The coordinates here are in pattern space. For a new pattern,
 * pattern space is identical to user space, but the relationship
 * between the spaces can be changed with [cairo.Pattern.setMatrix].
 * Params:
 *   x0 = x coordinate of the start point
 *   y0 = y coordinate of the start point
 *   x1 = x coordinate of the end point
 *   y1 = y coordinate of the end point
 * Returns: the newly created #cairo_pattern_t if successful, or
 *   an error pattern in case of no memory.  The caller owns the
 *   returned object and should call [cairo.Pattern.destroy] when
 *   finished with it.
 *   This function will always return a valid pointer, but if an error
 *   occurred the pattern status will be set to an error.  To inspect
 *   the status of a pattern use [cairo.Pattern.status].
 */
Pattern patternCreateLinear(double x0, double y0, double x1, double y1)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_linear(x0, y0, x1, y1);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Create a new mesh pattern.
 * Mesh patterns are tensor-product patch meshes $(LPAREN)type 7 shadings in
 * PDF$(RPAREN). Mesh patterns may also be used to create other types of
 * shadings that are special cases of tensor-product patch meshes such
 * as Coons patch meshes $(LPAREN)type 6 shading in PDF$(RPAREN) and Gouraud-shaded
 * triangle meshes $(LPAREN)type 4 and 5 shadings in PDF$(RPAREN).
 * Mesh patterns consist of one or more tensor-product patches, which
 * should be defined before using the mesh pattern. Using a mesh
 * pattern with a partially defined patch as source or mask will put
 * the context in an error status with a status of
 * %CAIRO_STATUS_INVALID_MESH_CONSTRUCTION.
 * A tensor-product patch is defined by 4 Bézier curves $(LPAREN)side 0, 1, 2,
 * 3$(RPAREN) and by 4 additional control points $(LPAREN)P0, P1, P2, P3$(RPAREN) that provide
 * further control over the patch and complete the definition of the
 * tensor-product patch. The corner C0 is the first point of the
 * patch.
 * Degenerate sides are permitted so straight lines may be used. A
 * zero length line on one side may be used to create 3 sided patches.
 * <informalexample><screen>
 * C1     Side 1       C2
 * +---------------+
 * |               |
 * |  P1       P2  |
 * |               |
 * Side 0 |               | Side 2
 * |               |
 * |               |
 * |  P0       P3  |
 * |               |
 * +---------------+
 * C0     Side 3        C3
 * </screen></informalexample>
 * Each patch is constructed by first calling
 * [cairo.Global.meshPatternBeginPatch], then [cairo.Global.meshPatternMoveTo]
 * to specify the first point in the patch $(LPAREN)C0$(RPAREN). Then the sides are
 * specified with calls to [cairo.Global.meshPatternCurveTo] and
 * [cairo.Global.meshPatternLineTo].
 * The four additional control points $(LPAREN)P0, P1, P2, P3$(RPAREN) in a patch can
 * be specified with [cairo.Global.meshPatternSetControlPoint].
 * At each corner of the patch $(LPAREN)C0, C1, C2, C3$(RPAREN) a color may be
 * specified with [cairo.Global.meshPatternSetCornerColorRgb] or
 * [cairo.Global.meshPatternSetCornerColorRgba]. Any corner whose color
 * is not explicitly specified defaults to transparent black.
 * A Coons patch is a special case of the tensor-product patch where
 * the control points are implicitly defined by the sides of the
 * patch. The default value for any control point not specified is the
 * implicit value for a Coons patch, i.e. if no control points are
 * specified the patch is a Coons patch.
 * A triangle is a special case of the tensor-product patch where the
 * control points are implicitly defined by the sides of the patch,
 * all the sides are lines and one of them has length 0, i.e. if the
 * patch is specified using just 3 lines, it is a triangle. If the
 * corners connected by the 0-length side have the same color, the
 * patch is a Gouraud-shaded triangle.
 * Patches may be oriented differently to the above diagram. For
 * example the first point could be at the top left. The diagram only
 * shows the relationship between the sides, corners and control
 * points. Regardless of where the first point is located, when
 * specifying colors, corner 0 will always be the first point, corner
 * 1 the point between side 0 and side 1 etc.
 * Calling [cairo.Global.meshPatternEndPatch] completes the current
 * patch. If less than 4 sides have been defined, the first missing
 * side is defined as a line from the current point to the first point
 * of the patch $(LPAREN)C0$(RPAREN) and the other sides are degenerate lines from C0
 * to C0. The corners between the added sides will all be coincident
 * with C0 of the patch and their color will be set to be the same as
 * the color of C0.
 * Additional patches may be added with additional calls to
 * [cairo.Global.meshPatternBeginPatch]/[cairo.Global.meshPatternEndPatch].
 * <informalexample><programlisting>
 * cairo_pattern_t *pattern \= cairo_pattern_create_mesh $(LPAREN)$(RPAREN);
 * /&ast; Add a Coons patch &ast;/
 * cairo_mesh_pattern_begin_patch $(LPAREN)pattern$(RPAREN);
 * cairo_mesh_pattern_move_to $(LPAREN)pattern, 0, 0$(RPAREN);
 * cairo_mesh_pattern_curve_to $(LPAREN)pattern, 30, -30,  60,  30, 100, 0$(RPAREN);
 * cairo_mesh_pattern_curve_to $(LPAREN)pattern, 60,  30, 130,  60, 100, 100$(RPAREN);
 * cairo_mesh_pattern_curve_to $(LPAREN)pattern, 60,  70,  30, 130,   0, 100$(RPAREN);
 * cairo_mesh_pattern_curve_to $(LPAREN)pattern, 30,  70, -30,  30,   0, 0$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 0, 1, 0, 0$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 1, 0, 1, 0$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 2, 0, 0, 1$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 3, 1, 1, 0$(RPAREN);
 * cairo_mesh_pattern_end_patch $(LPAREN)pattern$(RPAREN);
 * /&ast; Add a Gouraud-shaded triangle &ast;/
 * cairo_mesh_pattern_begin_patch $(LPAREN)pattern$(RPAREN)
 * cairo_mesh_pattern_move_to $(LPAREN)pattern, 100, 100$(RPAREN);
 * cairo_mesh_pattern_line_to $(LPAREN)pattern, 130, 130$(RPAREN);
 * cairo_mesh_pattern_line_to $(LPAREN)pattern, 130,  70$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 0, 1, 0, 0$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 1, 0, 1, 0$(RPAREN);
 * cairo_mesh_pattern_set_corner_color_rgb $(LPAREN)pattern, 2, 0, 0, 1$(RPAREN);
 * cairo_mesh_pattern_end_patch $(LPAREN)pattern$(RPAREN)
 * </programlisting></informalexample>
 * When two patches overlap, the last one that has been added is drawn
 * over the first one.
 * When a patch folds over itself, points are sorted depending on
 * their parameter coordinates inside the patch. The v coordinate
 * ranges from 0 to 1 when moving from side 3 to side 1; the u
 * coordinate ranges from 0 to 1 when going from side 0 to side
 * 2. Points with higher v coordinate hide points with lower v
 * coordinate. When two points have the same v coordinate, the one
 * with higher u coordinate is above. This means that points nearer to
 * side 1 are above points nearer to side 3; when this is not
 * sufficient to decide which point is above $(LPAREN)for example when both
 * points belong to side 1 or side 3$(RPAREN) points nearer to side 2 are
 * above points nearer to side 0.
 * For a complete definition of tensor-product patches, see the PDF
 * specification $(LPAREN)ISO32000$(RPAREN), which describes the parametrization in
 * detail.
 * Note: The coordinates are always in pattern space. For a new
 * pattern, pattern space is identical to user space, but the
 * relationship between the spaces can be changed with
 * [cairo.Pattern.setMatrix].
 * Returns: the newly created #cairo_pattern_t if successful, or
 *   an error pattern in case of no memory. The caller owns the returned
 *   object and should call [cairo.Pattern.destroy] when finished with
 *   it.
 *   This function will always return a valid pointer, but if an error
 *   occurred the pattern status will be set to an error. To inspect the
 *   status of a pattern use [cairo.Pattern.status].
 */
Pattern patternCreateMesh()
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_mesh();
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new radial gradient #cairo_pattern_t between the two
 * circles defined by $(LPAREN)cx0, cy0, radius0$(RPAREN) and $(LPAREN)cx1, cy1, radius1$(RPAREN).  Before using the
 * gradient pattern, a number of color stops should be defined using
 * [cairo.Pattern.addColorStopRgb] or
 * [cairo.Pattern.addColorStopRgba].
 * Note: The coordinates here are in pattern space. For a new pattern,
 * pattern space is identical to user space, but the relationship
 * between the spaces can be changed with [cairo.Pattern.setMatrix].
 * Params:
 *   cx0 = x coordinate for the center of the start circle
 *   cy0 = y coordinate for the center of the start circle
 *   radius0 = radius of the start circle
 *   cx1 = x coordinate for the center of the end circle
 *   cy1 = y coordinate for the center of the end circle
 *   radius1 = radius of the end circle
 * Returns: the newly created #cairo_pattern_t if successful, or
 *   an error pattern in case of no memory.  The caller owns the
 *   returned object and should call [cairo.Pattern.destroy] when
 *   finished with it.
 *   This function will always return a valid pointer, but if an error
 *   occurred the pattern status will be set to an error.  To inspect
 *   the status of a pattern use [cairo.Pattern.status].
 */
Pattern patternCreateRadial(double cx0, double cy0, double radius0, double cx1, double cy1, double radius1)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_radial(cx0, cy0, radius0, cx1, cy1, radius1);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new user pattern for providing pixel data.
 * Use the setter functions to associate callbacks with the returned
 * pattern.  The only mandatory callback is acquire.
 * Params:
 *   userData = the user data to be passed to all callbacks
 *   content = content type for the pixel data that will be returned. Knowing
 *     the content type ahead of time is used for analysing the operation and
 *     picking the appropriate rendering path.
 *   width = maximum size of the sample area
 *   height = maximum size of the sample area
 * Returns: a newly created #cairo_pattern_t. Free with
 *   [cairo.Pattern.destroy] when you are done using it.
 */
Pattern patternCreateRasterSource(void* userData, Content content, int width, int height)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_raster_source(userData, content, width, height);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #cairo_pattern_t corresponding to an opaque color.  The
 * color components are floating point numbers in the range 0 to 1.
 * If the values passed in are outside that range, they will be
 * clamped.
 * Params:
 *   red = red component of the color
 *   green = green component of the color
 *   blue = blue component of the color
 * Returns: the newly created #cairo_pattern_t if successful, or
 *   an error pattern in case of no memory.  The caller owns the
 *   returned object and should call [cairo.Pattern.destroy] when
 *   finished with it.
 *   This function will always return a valid pointer, but if an error
 *   occurred the pattern status will be set to an error.  To inspect
 *   the status of a pattern use [cairo.Pattern.status].
 */
Pattern patternCreateRgb(double red, double green, double blue)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_rgb(red, green, blue);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a new #cairo_pattern_t corresponding to a translucent color.
 * The color components are floating point numbers in the range 0 to
 * 1.  If the values passed in are outside that range, they will be
 * clamped.
 * The color is specified in the same way as in [cairo.Context.setSourceRgb].
 * Params:
 *   red = red component of the color
 *   green = green component of the color
 *   blue = blue component of the color
 *   alpha = alpha component of the color
 * Returns: the newly created #cairo_pattern_t if successful, or
 *   an error pattern in case of no memory.  The caller owns the
 *   returned object and should call [cairo.Pattern.destroy] when
 *   finished with it.
 *   This function will always return a valid pointer, but if an error
 *   occurred the pattern status will be set to an error.  To inspect
 *   the status of a pattern use [cairo.Pattern.status].
 */
Pattern patternCreateRgba(double red, double green, double blue, double alpha)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_pattern_create_rgba(red, green, blue, alpha);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Add an item to the document outline hierarchy with the name utf8
 * that links to the location specified by link_attribs. Link
 * attributes have the same keys and values as the [Link Tag][link],
 * excluding the "rect" attribute. The item will be a child of the
 * item with id parent_id. Use %CAIRO_PDF_OUTLINE_ROOT as the parent
 * id of top level items.
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   parentId = the id of the parent item or %CAIRO_PDF_OUTLINE_ROOT if this is a top level item.
 *   utf8 = the name of the outline
 *   linkAttribs = the link attributes specifying where this outline links to
 *   flags = outline item flags
 * Returns: the id for the added item.
 */
int pdfSurfaceAddOutline(Surface surface, int parentId, string utf8, string linkAttribs, PdfOutlineFlags flags)
{
  int _retval;
  const(char)* _utf8 = utf8.toCString(false);
  const(char)* _linkAttribs = linkAttribs.toCString(false);
  _retval = cairo_pdf_surface_add_outline(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, parentId, _utf8, _linkAttribs, flags);
  return _retval;
}

/**
 * Creates a PDF surface of the specified size in points to be written
 * to filename.
 * Params:
 *   filename = a filename for the PDF output $(LPAREN)must be writable$(RPAREN), %NULL may be
 *     used to specify no output. This will generate a PDF surface that
 *     may be queried and used as a source, without generating a
 *     temporary file.
 *   widthInPoints = width of the surface, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 *   heightInPoints = height of the surface, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" surface if an error such as out of memory
 *   occurs. You can use [cairo.Surface.status] to check for this.
 */
Surface pdfSurfaceCreate(string filename, double widthInPoints, double heightInPoints)
{
  cairo_surface_t* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = cairo_pdf_surface_create(_filename, widthInPoints, heightInPoints);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Restricts the generated PDF file to version. See [cairo.Global.pdfGetVersions]
 * for a list of available version values that can be used here.
 * This function should only be called before any drawing operations
 * have been performed on the given surface. The simplest way to do
 * this is to call this function immediately after creating the
 * surface.
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   version_ = PDF version
 */
void pdfSurfaceRestrictToVersion(Surface surface, PdfVersion version_)
{
  cairo_pdf_surface_restrict_to_version(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, version_);
}

/**
 * Set custom document metadata. name may be any string except for
 * the following names reserved by PDF: "Title", "Author", "Subject",
 * "Keywords", "Creator", "Producer", "CreationDate", "ModDate",
 * "Trapped".
 * If value is NULL or an empty string, the name metadata will not be set.
 * For example:
 * <informalexample><programlisting>
 * cairo_pdf_surface_set_custom_metadata $(LPAREN)surface, "ISBN", "978-0123456789"$(RPAREN);
 * </programlisting></informalexample>
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   name = The name of the custom metadata item to set $(LPAREN)utf8$(RPAREN).
 *   value = The value of the metadata $(LPAREN)utf8$(RPAREN).
 */
void pdfSurfaceSetCustomMetadata(Surface surface, string name, string value)
{
  const(char)* _name = name.toCString(false);
  const(char)* _value = value.toCString(false);
  cairo_pdf_surface_set_custom_metadata(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, _name, _value);
}

/**
 * Set document metadata. The %CAIRO_PDF_METADATA_CREATE_DATE and
 * %CAIRO_PDF_METADATA_MOD_DATE values must be in ISO-8601 format:
 * YYYY-MM-DDThh:mm:ss. An optional timezone of the form "[+/-]hh:mm"
 * or "Z" for UTC time can be appended. All other metadata values can be any UTF-8
 * string.
 * For example:
 * <informalexample><programlisting>
 * cairo_pdf_surface_set_metadata $(LPAREN)surface, CAIRO_PDF_METADATA_TITLE, "My Document"$(RPAREN);
 * cairo_pdf_surface_set_metadata $(LPAREN)surface, CAIRO_PDF_METADATA_CREATE_DATE, "2015-12-31T23:59+02:00"$(RPAREN);
 * </programlisting></informalexample>
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   metadata = The metadata item to set.
 *   utf8 = metadata value
 */
void pdfSurfaceSetMetadata(Surface surface, PdfMetadata metadata, string utf8)
{
  const(char)* _utf8 = utf8.toCString(false);
  cairo_pdf_surface_set_metadata(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, metadata, _utf8);
}

/**
 * Set page label for the current page.
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   utf8 = The page label.
 */
void pdfSurfaceSetPageLabel(Surface surface, string utf8)
{
  const(char)* _utf8 = utf8.toCString(false);
  cairo_pdf_surface_set_page_label(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, _utf8);
}

/**
 * Changes the size of a PDF surface for the current $(LPAREN)and
 * subsequent$(RPAREN) pages.
 * This function should only be called before any drawing operations
 * have been performed on the current page. The simplest way to do
 * this is to call this function immediately after creating the
 * surface or immediately after completing a page with either
 * [cairo.Context.showPage] or [cairo.Context.copyPage].
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   widthInPoints = new surface width, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 *   heightInPoints = new surface height, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 */
void pdfSurfaceSetSize(Surface surface, double widthInPoints, double heightInPoints)
{
  cairo_pdf_surface_set_size(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, widthInPoints, heightInPoints);
}

/**
 * Set the thumbnail image size for the current and all subsequent
 * pages. Setting a width or height of 0 disables thumbnails for the
 * current and subsequent pages.
 * Params:
 *   surface = a PDF #cairo_surface_t
 *   width = Thumbnail width.
 *   height = Thumbnail height
 */
void pdfSurfaceSetThumbnailSize(Surface surface, int width, int height)
{
  cairo_pdf_surface_set_thumbnail_size(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, width, height);
}

/**
 * Get the string representation of the given version id. This function
 * will return %NULL if version isn't valid. See [cairo.Global.pdfGetVersions]
 * for a way to get the list of valid version ids.
 * Params:
 *   version_ = a version id
 * Returns: the string associated to given version.
 */
string pdfVersionToString(PdfVersion version_)
{
  const(char)* _cretval;
  _cretval = cairo_pdf_version_to_string(version_);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Get the string representation of the given level id. This function
 * will return %NULL if level id isn't valid. See [cairo.Global.psGetLevels]
 * for a way to get the list of valid level ids.
 * Params:
 *   level = a level id
 * Returns: the string associated to given level.
 */
string psLevelToString(PsLevel level)
{
  const(char)* _cretval;
  _cretval = cairo_ps_level_to_string(level);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Creates a PostScript surface of the specified size in points to be
 * written to filename. See [cairo.Global.psSurfaceCreateForStream] for
 * a more flexible mechanism for handling the PostScript output than
 * simply writing it to a named file.
 * Note that the size of individual pages of the PostScript output can
 * vary. See [cairo.Global.psSurfaceSetSize].
 * Params:
 *   filename = a filename for the PS output $(LPAREN)must be writable$(RPAREN), %NULL may be
 *     used to specify no output. This will generate a PS surface that
 *     may be queried and used as a source, without generating a
 *     temporary file.
 *   widthInPoints = width of the surface, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 *   heightInPoints = height of the surface, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" surface if an error such as out of memory
 *   occurs. You can use [cairo.Surface.status] to check for this.
 */
Surface psSurfaceCreate(string filename, double widthInPoints, double heightInPoints)
{
  cairo_surface_t* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = cairo_ps_surface_create(_filename, widthInPoints, heightInPoints);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * This function indicates that subsequent calls to
 * [cairo.Global.psSurfaceDscComment] should direct comments to the
 * PageSetup section of the PostScript output.
 * This function call is only needed for the first page of a
 * surface. It should be called after any call to
 * [cairo.Global.psSurfaceDscBeginSetup] and before any drawing is
 * performed to the surface.
 * See [cairo.Global.psSurfaceDscComment] for more details.
 * Params:
 *   surface = a PostScript #cairo_surface_t
 */
void psSurfaceDscBeginPageSetup(Surface surface)
{
  cairo_ps_surface_dsc_begin_page_setup(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
}

/**
 * This function indicates that subsequent calls to
 * [cairo.Global.psSurfaceDscComment] should direct comments to the Setup
 * section of the PostScript output.
 * This function should be called at most once per surface, and must
 * be called before any call to [cairo.Global.psSurfaceDscBeginPageSetup]
 * and before any drawing is performed to the surface.
 * See [cairo.Global.psSurfaceDscComment] for more details.
 * Params:
 *   surface = a PostScript #cairo_surface_t
 */
void psSurfaceDscBeginSetup(Surface surface)
{
  cairo_ps_surface_dsc_begin_setup(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
}

/**
 * Emit a comment into the PostScript output for the given surface.
 * The comment is expected to conform to the PostScript Language
 * Document Structuring Conventions $(LPAREN)DSC$(RPAREN). Please see that manual for
 * details on the available comments and their meanings. In
 * particular, the \%\%IncludeFeature comment allows a
 * device-independent means of controlling printer device features. So
 * the PostScript Printer Description Files Specification will also be
 * a useful reference.
 * The comment string must begin with a percent character $(LPAREN)\%$(RPAREN) and the
 * total length of the string $(LPAREN)including any initial percent
 * characters$(RPAREN) must not exceed 255 characters. Violating either of
 * these conditions will place surface into an error state. But
 * beyond these two conditions, this function will not enforce
 * conformance of the comment with any particular specification.
 * The comment string must not contain any newline characters.
 * The DSC specifies different sections in which particular comments
 * can appear. This function provides for comments to be emitted
 * within three sections: the header, the Setup section, and the
 * PageSetup section.  Comments appearing in the first two sections
 * apply to the entire document while comments in the BeginPageSetup
 * section apply only to a single page.
 * For comments to appear in the header section, this function should
 * be called after the surface is created, but before a call to
 * [cairo.Global.psSurfaceDscBeginSetup].
 * For comments to appear in the Setup section, this function should
 * be called after a call to [cairo.Global.psSurfaceDscBeginSetup] but
 * before a call to [cairo.Global.psSurfaceDscBeginPageSetup].
 * For comments to appear in the PageSetup section, this function
 * should be called after a call to
 * [cairo.Global.psSurfaceDscBeginPageSetup].
 * Note that it is only necessary to call
 * [cairo.Global.psSurfaceDscBeginPageSetup] for the first page of any
 * surface. After a call to [cairo.Context.showPage] or [cairo.Context.copyPage]
 * comments are unambiguously directed to the PageSetup section of the
 * current page. But it doesn't hurt to call this function at the
 * beginning of every page as that consistency may make the calling
 * code simpler.
 * As a final note, cairo automatically generates several comments on
 * its own. As such, applications must not manually generate any of
 * the following comments:
 * Header section: \%!PS-Adobe-3.0, \%\%Creator, \%\%CreationDate, \%\%Pages,
 * \%\%BoundingBox, \%\%DocumentData, \%\%LanguageLevel, \%\%EndComments.
 * Setup section: \%\%BeginSetup, \%\%EndSetup
 * PageSetup section: \%\%BeginPageSetup, \%\%PageBoundingBox, \%\%EndPageSetup.
 * Other sections: \%\%BeginProlog, \%\%EndProlog, \%\%Page, \%\%Trailer, \%\%EOF
 * Here is an example sequence showing how this function might be used:
 * <informalexample><programlisting>
 * cairo_surface_t *surface \= cairo_ps_surface_create $(LPAREN)filename, width, height$(RPAREN);
 * ...
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%Title: My excellent document"$(RPAREN);
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%Copyright: Copyright $(LPAREN)C$(RPAREN) 2006 Cairo Lover"$(RPAREN)
 * ...
 * cairo_ps_surface_dsc_begin_setup $(LPAREN)surface$(RPAREN);
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%IncludeFeature: *MediaColor White"$(RPAREN);
 * ...
 * cairo_ps_surface_dsc_begin_page_setup $(LPAREN)surface$(RPAREN);
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%IncludeFeature: *PageSize A3"$(RPAREN);
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%IncludeFeature: *InputSlot LargeCapacity"$(RPAREN);
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%IncludeFeature: *MediaType Glossy"$(RPAREN);
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%IncludeFeature: *MediaColor Blue"$(RPAREN);
 * ... draw to first page here ..
 * cairo_show_page $(LPAREN)cr$(RPAREN);
 * ...
 * cairo_ps_surface_dsc_comment $(LPAREN)surface, "%%IncludeFeature: *PageSize A5"$(RPAREN);
 * ...
 * </programlisting></informalexample>
 * Params:
 *   surface = a PostScript #cairo_surface_t
 *   comment = a comment string to be emitted into the PostScript output
 */
void psSurfaceDscComment(Surface surface, string comment)
{
  const(char)* _comment = comment.toCString(false);
  cairo_ps_surface_dsc_comment(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, _comment);
}

/**
 * Check whether the PostScript surface will output Encapsulated PostScript.
 * Params:
 *   surface = a PostScript #cairo_surface_t
 * Returns: %TRUE if the surface will output Encapsulated PostScript.
 */
Bool psSurfaceGetEps(Surface surface)
{
  Bool _retval;
  _retval = cairo_ps_surface_get_eps(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  return _retval;
}

/**
 * Restricts the generated PostSript file to level. See
 * [cairo.Global.psGetLevels] for a list of available level values that
 * can be used here.
 * This function should only be called before any drawing operations
 * have been performed on the given surface. The simplest way to do
 * this is to call this function immediately after creating the
 * surface.
 * Params:
 *   surface = a PostScript #cairo_surface_t
 *   level = PostScript level
 */
void psSurfaceRestrictToLevel(Surface surface, PsLevel level)
{
  cairo_ps_surface_restrict_to_level(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, level);
}

/**
 * If eps is %TRUE, the PostScript surface will output Encapsulated
 * PostScript.
 * This function should only be called before any drawing operations
 * have been performed on the current page. The simplest way to do
 * this is to call this function immediately after creating the
 * surface. An Encapsulated PostScript file should never contain more
 * than one page.
 * Params:
 *   surface = a PostScript #cairo_surface_t
 *   eps = %TRUE to output EPS format PostScript
 */
void psSurfaceSetEps(Surface surface, Bool eps)
{
  cairo_ps_surface_set_eps(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, eps);
}

/**
 * Changes the size of a PostScript surface for the current $(LPAREN)and
 * subsequent$(RPAREN) pages.
 * This function should only be called before any drawing operations
 * have been performed on the current page. The simplest way to do
 * this is to call this function immediately after creating the
 * surface or immediately after completing a page with either
 * [cairo.Context.showPage] or [cairo.Context.copyPage].
 * Params:
 *   surface = a PostScript #cairo_surface_t
 *   widthInPoints = new surface width, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 *   heightInPoints = new surface height, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 */
void psSurfaceSetSize(Surface surface, double widthInPoints, double heightInPoints)
{
  cairo_ps_surface_set_size(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, widthInPoints, heightInPoints);
}

/**
 * Queries the current user data.
 * Params:
 *   pattern = the pattern to update
 * Returns: the current user-data passed to each callback
 */
void* rasterSourcePatternGetCallbackData(Pattern pattern)
{
  void* _retval;
  _retval = cairo_raster_source_pattern_get_callback_data(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null);
  return _retval;
}

/**
 * Updates the user data that is provided to all callbacks.
 * Params:
 *   pattern = the pattern to update
 *   data = the user data to be passed to all callbacks
 */
void rasterSourcePatternSetCallbackData(Pattern pattern, void* data)
{
  cairo_raster_source_pattern_set_callback_data(pattern ? cast(cairo_pattern_t*)pattern.cPtr(false) : null, data);
}

/**
 * Creates a recording-surface which can be used to record all drawing operations
 * at the highest level $(LPAREN)that is, the level of paint, mask, stroke, fill
 * and show_text_glyphs$(RPAREN). The recording surface can then be "replayed" against
 * any target surface by using it as a source to drawing operations.
 * The recording phase of the recording surface is careful to snapshot all
 * necessary objects $(LPAREN)paths, patterns, etc.$(RPAREN), in order to achieve
 * accurate replay.
 * Params:
 *   content = the content of the recording surface
 *   extents = the extents to record in pixels, can be %NULL to record
 *     unbounded operations.
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 */
Surface recordingSurfaceCreate(Content content, Rectangle extents)
{
  cairo_surface_t* _cretval;
  _cretval = cairo_recording_surface_create(content, extents ? cast(cairo_rectangle_t*)extents.cPtr(false) : null);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Get the extents of the recording-surface.
 * Params:
 *   surface = a #cairo_recording_surface_t
 *   extents = the #cairo_rectangle_t to be assigned the extents
 * Returns: %TRUE if the surface is bounded, of recording type, and
 *   not in an error state, otherwise %FALSE
 */
Bool recordingSurfaceGetExtents(Surface surface, Rectangle extents)
{
  Bool _retval;
  _retval = cairo_recording_surface_get_extents(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, extents ? cast(cairo_rectangle_t*)extents.cPtr(false) : null);
  return _retval;
}

/**
 * Measures the extents of the operations stored within the recording-surface.
 * This is useful to compute the required size of an image surface $(LPAREN)or
 * equivalent$(RPAREN) into which to replay the full sequence of drawing operations.
 * Params:
 *   surface = a #cairo_recording_surface_t
 *   x0 = the x-coordinate of the top-left of the ink bounding box
 *   y0 = the y-coordinate of the top-left of the ink bounding box
 *   width = the width of the ink bounding box
 *   height = the height of the ink bounding box
 */
void recordingSurfaceInkExtents(Surface surface, out double x0, out double y0, out double width, out double height)
{
  cairo_recording_surface_ink_extents(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, cast(double*)&x0, cast(double*)&y0, cast(double*)&width, cast(double*)&height);
}

/**
 * Allocates a new empty region object.
 * Returns: A newly allocated #cairo_region_t. Free with
 *   [cairo.Region.destroy]. This function always returns a
 *   valid pointer; if memory cannot be allocated, then a special
 *   error object is returned where all operations on the object do nothing.
 *   You can check for this with [cairo.Region.status].
 */
Region regionCreate()
{
  cairo_region_t* _cretval;
  _cretval = cairo_region_create();
  auto _retval = _cretval ? new Region(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Allocates a new region object containing rectangle.
 * Params:
 *   rectangle = a #cairo_rectangle_int_t
 * Returns: A newly allocated #cairo_region_t. Free with
 *   [cairo.Region.destroy]. This function always returns a
 *   valid pointer; if memory cannot be allocated, then a special
 *   error object is returned where all operations on the object do nothing.
 *   You can check for this with [cairo.Region.status].
 */
Region regionCreateRectangle(RectangleInt rectangle)
{
  cairo_region_t* _cretval;
  _cretval = cairo_region_create_rectangle(rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
  auto _retval = _cretval ? new Region(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Allocates a new region object containing the union of all given rects.
 * Params:
 *   rects = an array of count rectangles
 *   count = number of rectangles
 * Returns: A newly allocated #cairo_region_t. Free with
 *   [cairo.Region.destroy]. This function always returns a
 *   valid pointer; if memory cannot be allocated, then a special
 *   error object is returned where all operations on the object do nothing.
 *   You can check for this with [cairo.Region.status].
 */
Region regionCreateRectangles(RectangleInt rects, int count)
{
  cairo_region_t* _cretval;
  _cretval = cairo_region_create_rectangles(rects ? cast(cairo_rectangle_int_t*)rects.cPtr(false) : null, count);
  auto _retval = _cretval ? new Region(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a #cairo_scaled_font_t object from a font face and matrices that
 * describe the size of the font and the environment in which it will
 * be used.
 * Params:
 *   fontFace = a #cairo_font_face_t
 *   fontMatrix = font space to user space transformation matrix for the
 *     font. In the simplest case of a N point font, this matrix is
 *     just a scale by N, but it can also be used to shear the font
 *     or stretch it unequally along the two axes. See
 *     [cairo.Context.setFontMatrix].
 *   ctm = user to device transformation matrix with which the font will
 *     be used.
 *   options = options to use when getting metrics for the font and
 *     rendering with it.
 * Returns: a newly created #cairo_scaled_font_t. Destroy with
 *   [cairo.ScaledFont.destroy]
 */
ScaledFont scaledFontCreate(FontFace fontFace, Matrix fontMatrix, Matrix ctm, FontOptions options)
{
  cairo_scaled_font_t* _cretval;
  _cretval = cairo_scaled_font_create(fontFace ? cast(cairo_font_face_t*)fontFace.cPtr(false) : null, fontMatrix ? cast(cairo_matrix_t*)fontMatrix.cPtr(false) : null, ctm ? cast(cairo_matrix_t*)ctm.cPtr(false) : null, options ? cast(cairo_font_options_t*)options.cPtr(false) : null);
  auto _retval = _cretval ? new ScaledFont(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a output device for emitting the script, used when
 * creating the individual surfaces.
 * Params:
 *   filename = the name $(LPAREN)path$(RPAREN) of the file to write the script to
 * Returns: a pointer to the newly created device. The caller
 *   owns the surface and should call [cairo.Device.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" device if an error such as out of memory
 *   occurs. You can use [cairo.Device.status] to check for this.
 */
Device scriptCreate(string filename)
{
  cairo_device_t* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = cairo_script_create(_filename);
  auto _retval = _cretval ? new Device(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Converts the record operations in recording_surface into a script.
 * Params:
 *   script = the script $(LPAREN)output device$(RPAREN)
 *   recordingSurface = the recording surface to replay
 * Returns: #CAIRO_STATUS_SUCCESS on successful completion or an error code.
 */
Status scriptFromRecordingSurface(Device script, Surface recordingSurface)
{
  cairo_status_t _cretval;
  _cretval = cairo_script_from_recording_surface(script ? cast(cairo_device_t*)script.cPtr(false) : null, recordingSurface ? cast(cairo_surface_t*)recordingSurface.cPtr(false) : null);
  Status _retval = cast(Status)_cretval;
  return _retval;
}

/**
 * Queries the script for its current output mode.
 * Params:
 *   script = The script $(LPAREN)output device$(RPAREN) to query
 * Returns: the current output mode of the script
 */
ScriptMode scriptGetMode(Device script)
{
  cairo_script_mode_t _cretval;
  _cretval = cairo_script_get_mode(script ? cast(cairo_device_t*)script.cPtr(false) : null);
  ScriptMode _retval = cast(ScriptMode)_cretval;
  return _retval;
}

/**
 * Change the output mode of the script
 * Params:
 *   script = The script $(LPAREN)output device$(RPAREN)
 *   mode = the new mode
 */
void scriptSetMode(Device script, ScriptMode mode)
{
  cairo_script_set_mode(script ? cast(cairo_device_t*)script.cPtr(false) : null, mode);
}

/**
 * Create a new surface that will emit its rendering through script
 * Params:
 *   script = the script $(LPAREN)output device$(RPAREN)
 *   content = the content of the surface
 *   width = width in pixels
 *   height = height in pixels
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" surface if an error such as out of memory
 *   occurs. You can use [cairo.Surface.status] to check for this.
 */
Surface scriptSurfaceCreate(Device script, Content content, double width, double height)
{
  cairo_surface_t* _cretval;
  _cretval = cairo_script_surface_create(script ? cast(cairo_device_t*)script.cPtr(false) : null, content, width, height);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Create a pxoy surface that will render to target and record
 * the operations to device.
 * Params:
 *   script = the script $(LPAREN)output device$(RPAREN)
 *   target = a target surface to wrap
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" surface if an error such as out of memory
 *   occurs. You can use [cairo.Surface.status] to check for this.
 */
Surface scriptSurfaceCreateForTarget(Device script, Surface target)
{
  cairo_surface_t* _cretval;
  _cretval = cairo_script_surface_create_for_target(script ? cast(cairo_device_t*)script.cPtr(false) : null, target ? cast(cairo_surface_t*)target.cPtr(false) : null);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Emit a string verbatim into the script.
 * Params:
 *   script = the script $(LPAREN)output device$(RPAREN)
 *   comment = the string to emit
 *   len = the length of the string to write, or -1 to use strlen$(LPAREN)$(RPAREN)
 */
void scriptWriteComment(Device script, string comment, int len)
{
  const(char)* _comment = comment.toCString(false);
  cairo_script_write_comment(script ? cast(cairo_device_t*)script.cPtr(false) : null, _comment, len);
}

/**
 * Provides a human-readable description of a #cairo_status_t.
 * Params:
 *   status = a cairo status
 * Returns: a string representation of the status
 */
string statusToString(Status status)
{
  const(char)* _cretval;
  _cretval = cairo_status_to_string(status);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Creates a SVG surface of the specified size in points to be written
 * to filename.
 * The SVG surface backend recognizes the following MIME types for the
 * data attached to a surface $(LPAREN)see [cairo.Surface.setMimeData]$(RPAREN) when
 * it is used as a source pattern for drawing on this surface:
 * %CAIRO_MIME_TYPE_JPEG, %CAIRO_MIME_TYPE_PNG,
 * %CAIRO_MIME_TYPE_URI. If any of them is specified, the SVG backend
 * emits a href with the content of MIME data instead of a surface
 * snapshot $(LPAREN)PNG, Base64-encoded$(RPAREN) in the corresponding image tag.
 * The unofficial MIME type %CAIRO_MIME_TYPE_URI is examined
 * first. If present, the URI is emitted as is: assuring the
 * correctness of URI is left to the client code.
 * If %CAIRO_MIME_TYPE_URI is not present, but %CAIRO_MIME_TYPE_JPEG
 * or %CAIRO_MIME_TYPE_PNG is specified, the corresponding data is
 * Base64-encoded and emitted.
 * If %CAIRO_MIME_TYPE_UNIQUE_ID is present, all surfaces with the same
 * unique identifier will only be embedded once.
 * Params:
 *   filename = a filename for the SVG output $(LPAREN)must be writable$(RPAREN), %NULL may be
 *     used to specify no output. This will generate a SVG surface that
 *     may be queried and used as a source, without generating a
 *     temporary file.
 *   widthInPoints = width of the surface, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 *   heightInPoints = height of the surface, in points $(LPAREN)1 point \=\= 1/72.0 inch$(RPAREN)
 * Returns: a pointer to the newly created surface. The caller
 *   owns the surface and should call [cairo.Surface.destroy] when done
 *   with it.
 *   This function always returns a valid pointer, but it will return a
 *   pointer to a "nil" surface if an error such as out of memory
 *   occurs. You can use [cairo.Surface.status] to check for this.
 */
Surface svgSurfaceCreate(string filename, double widthInPoints, double heightInPoints)
{
  cairo_surface_t* _cretval;
  const(char)* _filename = filename.toCString(false);
  _cretval = cairo_svg_surface_create(_filename, widthInPoints, heightInPoints);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Get the unit of the SVG surface.
 * If the surface passed as an argument is not a SVG surface, the function
 * sets the error status to CAIRO_STATUS_SURFACE_TYPE_MISMATCH and returns
 * CAIRO_SVG_UNIT_USER.
 * Params:
 *   surface = a SVG #cairo_surface_t
 * Returns: the SVG unit of the SVG surface.
 */
SvgUnit svgSurfaceGetDocumentUnit(Surface surface)
{
  cairo_svg_unit_t _cretval;
  _cretval = cairo_svg_surface_get_document_unit(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null);
  SvgUnit _retval = cast(SvgUnit)_cretval;
  return _retval;
}

/**
 * Restricts the generated SVG file to version. See [cairo.Global.svgGetVersions]
 * for a list of available version values that can be used here.
 * This function should only be called before any drawing operations
 * have been performed on the given surface. The simplest way to do
 * this is to call this function immediately after creating the
 * surface.
 * Params:
 *   surface = a SVG #cairo_surface_t
 *   version_ = SVG version
 */
void svgSurfaceRestrictToVersion(Surface surface, SvgVersion version_)
{
  cairo_svg_surface_restrict_to_version(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, version_);
}

/**
 * Use the specified unit for the width and height of the generated SVG file.
 * See #cairo_svg_unit_t for a list of available unit values that can be used
 * here.
 * This function can be called at any time before generating the SVG file.
 * However to minimize the risk of ambiguities it's recommended to call it
 * before any drawing operations have been performed on the given surface, to
 * make it clearer what the unit used in the drawing operations is.
 * The simplest way to do this is to call this function immediately after
 * creating the SVG surface.
 * Note if this function is never called, the default unit for SVG documents
 * generated by cairo will be user unit.
 * Params:
 *   surface = a SVG #cairo_surface_t
 *   unit = SVG unit
 */
void svgSurfaceSetDocumentUnit(Surface surface, SvgUnit unit)
{
  cairo_svg_surface_set_document_unit(surface ? cast(cairo_surface_t*)surface.cPtr(false) : null, unit);
}

/**
 * Get the string representation of the given version id. This function
 * will return %NULL if version isn't valid. See [cairo.Global.svgGetVersions]
 * for a way to get the list of valid version ids.
 * Params:
 *   version_ = a version id
 * Returns: the string associated to given version.
 */
string svgVersionToString(SvgVersion version_)
{
  const(char)* _cretval;
  _cretval = cairo_svg_version_to_string(version_);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Adds a new target surface to the list of replicas of a
 * tee surface.
 * Params:
 *   abstractSurface = a #cairo_tee_surface_t
 *   target = the surface to add
 */
void teeSurfaceAdd(Surface abstractSurface, Surface target)
{
  cairo_tee_surface_add(abstractSurface ? cast(cairo_surface_t*)abstractSurface.cPtr(false) : null, target ? cast(cairo_surface_t*)target.cPtr(false) : null);
}

/**
 * Creates a new "tee" surface.
 * The primary surface is used when querying surface options, like
 * font options and extents.
 * Operations performed on the tee surface will be replayed on any
 * surface added to it.
 * Params:
 *   primary = the primary #cairo_surface_t
 * Returns: the newly created surface
 */
Surface teeSurfaceCreate(Surface primary)
{
  cairo_surface_t* _cretval;
  _cretval = cairo_tee_surface_create(primary ? cast(cairo_surface_t*)primary.cPtr(false) : null);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Retrieves the replica surface at the given index.
 * The primary surface used to create the #cairo_tee_surface_t is
 * always set at the zero index.
 * Params:
 *   abstractSurface = a #cairo_tee_surface_t
 *   index = the index of the replica to retrieve
 * Returns: the surface at the given index
 */
Surface teeSurfaceIndex(Surface abstractSurface, uint index)
{
  cairo_surface_t* _cretval;
  _cretval = cairo_tee_surface_index(abstractSurface ? cast(cairo_surface_t*)abstractSurface.cPtr(false) : null, index);
  auto _retval = _cretval ? new Surface(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Removes the given surface from the list of replicas of a
 * tee surface.
 * Params:
 *   abstractSurface = a #cairo_tee_surface_t
 *   target = the surface to remove
 */
void teeSurfaceRemove(Surface abstractSurface, Surface target)
{
  cairo_tee_surface_remove(abstractSurface ? cast(cairo_surface_t*)abstractSurface.cPtr(false) : null, target ? cast(cairo_surface_t*)target.cPtr(false) : null);
}

/**
 * Allocates an array of #cairo_text_cluster_t's.
 * This function is only useful in implementations of
 * #cairo_user_scaled_font_text_to_glyphs_func_t where the user
 * needs to allocate an array of text clusters that cairo will free.
 * For all other uses, user can use their own allocation method
 * for text clusters.
 * This function returns %NULL if num_clusters is not positive,
 * or if out of memory.  That means, the %NULL return value
 * signals out-of-memory only if num_clusters was positive.
 * Params:
 *   numClusters = number of text_clusters to allocate
 * Returns: the newly allocated array of text clusters that should be
 *   freed using [cairo.TextCluster.free]
 */
TextCluster textClusterAllocate(int numClusters)
{
  cairo_text_cluster_t* _cretval;
  _cretval = cairo_text_cluster_allocate(numClusters);
  auto _retval = _cretval ? new TextCluster(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a font face from a triplet of family, slant, and weight.
 * These font faces are used in implementation of the #cairo_t "toy"
 * font API.
 * If family is the zero-length string "", the platform-specific default
 * family is assumed.  The default family then can be queried using
 * [cairo.Global.toyFontFaceGetFamily].
 * The [cairo.Context.selectFontFace] function uses this to create font faces.
 * See that function for limitations and other details of toy font faces.
 * Params:
 *   family = a font family name, encoded in UTF-8
 *   slant = the slant for the font
 *   weight = the weight for the font
 * Returns: a newly created #cairo_font_face_t. Free with
 *   [cairo.FontFace.destroy] when you are done using it.
 */
FontFace toyFontFaceCreate(string family, FontSlant slant, FontWeight weight)
{
  cairo_font_face_t* _cretval;
  const(char)* _family = family.toCString(false);
  _cretval = cairo_toy_font_face_create(_family, slant, weight);
  auto _retval = _cretval ? new FontFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Gets the family name of a toy font.
 * Params:
 *   fontFace = A toy font face
 * Returns: The family name.  This string is owned by the font face
 *   and remains valid as long as the font face is alive $(LPAREN)referenced$(RPAREN).
 */
string toyFontFaceGetFamily(FontFace fontFace)
{
  const(char)* _cretval;
  _cretval = cairo_toy_font_face_get_family(fontFace ? cast(cairo_font_face_t*)fontFace.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Gets the slant a toy font.
 * Params:
 *   fontFace = A toy font face
 * Returns: The slant value
 */
FontSlant toyFontFaceGetSlant(FontFace fontFace)
{
  cairo_font_slant_t _cretval;
  _cretval = cairo_toy_font_face_get_slant(fontFace ? cast(cairo_font_face_t*)fontFace.cPtr(false) : null);
  FontSlant _retval = cast(FontSlant)_cretval;
  return _retval;
}

/**
 * Gets the weight a toy font.
 * Params:
 *   fontFace = A toy font face
 * Returns: The weight value
 */
FontWeight toyFontFaceGetWeight(FontFace fontFace)
{
  cairo_font_weight_t _cretval;
  _cretval = cairo_toy_font_face_get_weight(fontFace ? cast(cairo_font_face_t*)fontFace.cPtr(false) : null);
  FontWeight _retval = cast(FontWeight)_cretval;
  return _retval;
}

/**
 * Creates a new user font-face.
 * Use the setter functions to associate callbacks with the returned
 * user font.  The only mandatory callback is render_glyph.
 * After the font-face is created, the user can attach arbitrary data
 * $(LPAREN)the actual font data$(RPAREN) to it using [cairo.FontFace.setUserData]
 * and access it from the user-font callbacks by using
 * [cairo.ScaledFont.getFontFace] followed by
 * [cairo.FontFace.getUserData].
 * Returns: a newly created #cairo_font_face_t. Free with
 *   [cairo.FontFace.destroy] when you are done using it.
 */
FontFace userFontFaceCreate()
{
  cairo_font_face_t* _cretval;
  _cretval = cairo_user_font_face_create();
  auto _retval = _cretval ? new FontFace(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Gets the foreground pattern of the glyph currently being
 * rendered. A #cairo_user_scaled_font_render_glyph_func_t function
 * that has been set with
 * [cairo.Global.userFontFaceSetRenderColorGlyphFunc] may call this
 * function to retrieve the current foreground pattern for the glyph
 * being rendered. The function should not be called outside of a
 * [cairo.Global.userFontFaceSetRenderColorGlyphFunc] callback.
 * The foreground marker pattern contains an internal marker to
 * indicate that it is to be substituted with the current source when
 * rendered to a surface. Querying the foreground marker will reveal a
 * solid black color, however this is not representative of the color
 * that will actually be used. Similarly, setting a solid black color
 * will render black, not the foreground pattern when the glyph is
 * painted to a surface. Using the foreground marker as the source
 * instead of [cairo.Global.userScaledFontGetForegroundSource] in a
 * color render callback has the following benefits:
 * 1. Cairo only needs to call the render callback once as it can
 * cache the recording. Cairo will substitute the actual foreground
 * color when rendering the recording.
 * 2. On backends that have the concept of a foreground color in fonts such as
 * PDF, PostScript, and SVG, cairo can generate more optimal
 * output. The glyph can be included in an embedded font.
 * The one drawback of the using foreground marker is the render
 * callback can not access the color components of the pattern as the
 * actual foreground pattern is not available at the time the render
 * callback is invoked. If the render callback needs to query the
 * foreground pattern, use
 * [cairo.Global.userScaledFontGetForegroundSource].
 * If the render callback simply wants to call [cairo.Context.setSource] with
 * the foreground pattern,
 * [cairo.Global.userScaledFontGetForegroundMarker] is the preferred
 * function to use as it results in better performance than
 * [cairo.Global.userScaledFontGetForegroundSource].
 * Params:
 *   scaledFont = A user scaled font
 * Returns: the current foreground source marker pattern. This
 *   object is owned by cairo. This object must not be modified or used
 *   outside of a color render callback. To keep a reference to it,
 *   you must call [cairo.Pattern.reference].
 */
Pattern userScaledFontGetForegroundMarker(ScaledFont scaledFont)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_user_scaled_font_get_foreground_marker(scaledFont ? cast(cairo_scaled_font_t*)scaledFont.cPtr(false) : null);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Gets the foreground pattern of the glyph currently being
 * rendered. A #cairo_user_scaled_font_render_glyph_func_t function
 * that has been set with
 * [cairo.Global.userFontFaceSetRenderColorGlyphFunc] may call this
 * function to retrieve the current foreground pattern for the glyph
 * being rendered. The function should not be called outside of a
 * [cairo.Global.userFontFaceSetRenderColorGlyphFunc] callback.
 * This function returns the current source at the time the glyph is
 * rendered. Compared with
 * [cairo.Global.userScaledFontGetForegroundMarker], this function
 * returns the actual source pattern that will be used to render the
 * glyph.  The render callback is free to query the pattern and
 * extract color components or other pattern data. For example if the
 * render callback wants to create a gradient stop based on colors in
 * the foreground source pattern, it will need to use this function in
 * order to be able to query the colors in the foreground pattern.
 * While this function does not have the restrictions on using the
 * pattern that [cairo.Global.userScaledFontGetForegroundMarker] has, it
 * does incur a performance penalty. If a render callback calls this
 * function:
 * 1. Cairo will call the render callback whenever the current pattern
 * of the context in which the glyph is rendered changes.
 * 2. On backends that support font embedding $(LPAREN)PDF, PostScript, and
 * SVG$(RPAREN), cairo can not embed this glyph in a font. Instead the glyph
 * will be emitted as an image or sequence of drawing operations each
 * time it is used.
 * Params:
 *   scaledFont = A user scaled font
 * Returns: the current foreground source pattern. This object is
 *   owned by cairo. To keep a reference to it, you must call
 *   [cairo.Pattern.reference].
 */
Pattern userScaledFontGetForegroundSource(ScaledFont scaledFont)
{
  cairo_pattern_t* _cretval;
  _cretval = cairo_user_scaled_font_get_foreground_source(scaledFont ? cast(cairo_scaled_font_t*)scaledFont.cPtr(false) : null);
  auto _retval = _cretval ? new Pattern(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Returns the version of the cairo library encoded in a single
 * integer as per %CAIRO_VERSION_ENCODE. The encoding ensures that
 * later versions compare greater than earlier versions.
 * A run-time comparison to check that cairo's version is greater than
 * or equal to version X.Y.Z could be performed as follows:
 * <informalexample><programlisting>
 * if $(LPAREN)[cairo.Global.version_] >\= CAIRO_VERSION_ENCODE(X,Y,Z)$(RPAREN) {...}
 * </programlisting></informalexample>
 * See also [cairo.Global.versionString] as well as the compile-time
 * equivalents %CAIRO_VERSION and %CAIRO_VERSION_STRING.
 * Returns: the encoded version.
 */
int version_()
{
  int _retval;
  _retval = cairo_version();
  return _retval;
}

/**
 * Returns the version of the cairo library as a human-readable string
 * of the form "X.Y.Z".
 * See also [cairo.Global.version_] as well as the compile-time equivalents
 * %CAIRO_VERSION_STRING and %CAIRO_VERSION.
 * Returns: a string containing the version.
 */
string versionString()
{
  const(char)* _cretval;
  _cretval = cairo_version_string();
  string _retval = _cretval.fromCString(false);
  return _retval;
}
