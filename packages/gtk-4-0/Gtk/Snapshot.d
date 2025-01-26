module Gtk.Snapshot;

import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.RGBA;
import Gdk.Snapshot : DGdkSnapshot = Snapshot;
import Gdk.Texture;
import Gid.gid;
import Graphene.Matrix;
import Graphene.Point;
import Graphene.Point3D;
import Graphene.Rect;
import Graphene.Size;
import Graphene.Vec3;
import Graphene.Vec4;
import Gsk.ColorStop;
import Gsk.Path;
import Gsk.RenderNode;
import Gsk.RoundedRect;
import Gsk.Shadow;
import Gsk.Stroke;
import Gsk.Transform;
import Gsk.Types;
import Gtk.StyleContext;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.Layout;
import Pango.Types;
import cairo.Context;

/**
 * `GtkSnapshot` assists in creating [Gsk.RenderNode]s for widgets.
 * It functions in a similar way to a cairo context, and maintains a stack
 * of render nodes and their associated transformations.
 * The node at the top of the stack is the one that `gtk_snapshot_append_…$(LPAREN)$(RPAREN)`
 * functions operate on. Use the `gtk_snapshot_push_…$(LPAREN)$(RPAREN)` functions and
 * [Gtk.Snapshot.pop] to change the current node.
 * The typical way to obtain a `GtkSnapshot` object is as an argument to
 * the vfunc@Gtk.Widget.snapshot vfunc. If you need to create your own
 * `GtkSnapshot`, use [Gtk.Snapshot.new_].
 */
class Snapshot : DGdkSnapshot
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_snapshot_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkSnapshot`.
   * Returns: a newly-allocated `GtkSnapshot`
   */
  this()
  {
    GtkSnapshot* _cretval;
    _cretval = gtk_snapshot_new();
    this(_cretval, true);
  }

  /**
   * Appends a stroked border rectangle inside the given outline.
   * The four sides of the border can have different widths and colors.
   * Params:
   *   outline = the outline of the border
   *   borderWidth = the stroke width of the border on
   *     the top, right, bottom and left side respectively.
   *   borderColor = the color used on the top, right,
   *     bottom and left side.
   */
  void appendBorder(RoundedRect outline, float[] borderWidth, RGBA[] borderColor)
  {
    assert(!borderWidth || borderWidth.length == 4);
    auto _borderWidth = cast(const(float)*)borderWidth.ptr;
    assert(!borderColor || borderColor.length == 4);
    GdkRGBA[] _tmpborderColor;
    foreach (obj; borderColor)
      _tmpborderColor ~= *cast(GdkRGBA*)obj.cPtr;
    const(GdkRGBA)* _borderColor = _tmpborderColor.ptr;
    gtk_snapshot_append_border(cast(GtkSnapshot*)cPtr, outline ? cast(GskRoundedRect*)outline.cPtr : null, _borderWidth, _borderColor);
  }

  /**
   * Creates a new [Gsk.CairoNode] and appends it to the current
   * render node of snapshot, without changing the current node.
   * Params:
   *   bounds = the bounds for the new node
   * Returns: a `cairo_t` suitable for drawing the contents of
   *   the newly created render node
   */
  Context appendCairo(Rect bounds)
  {
    cairo_t* _cretval;
    _cretval = gtk_snapshot_append_cairo(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
    auto _retval = _cretval ? new Context(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new render node drawing the color into the
   * given bounds and appends it to the current render node
   * of snapshot.
   * You should try to avoid calling this function if
   * color is transparent.
   * Params:
   *   color = the color to draw
   *   bounds = the bounds for the new node
   */
  void appendColor(RGBA color, Rect bounds)
  {
    gtk_snapshot_append_color(cast(GtkSnapshot*)cPtr, color ? cast(GdkRGBA*)color.cPtr(false) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
  }

  /**
   * Appends a conic gradient node with the given stops to snapshot.
   * Params:
   *   bounds = the rectangle to render the gradient into
   *   center = the center point of the conic gradient
   *   rotation = the clockwise rotation in degrees of the starting angle.
   *     0 means the starting angle is the top.
   *   stops = the color stops defining the gradient
   */
  void appendConicGradient(Rect bounds, Point center, float rotation, ColorStop[] stops)
  {
    size_t _nStops;
    if (stops)
      _nStops = cast(size_t)stops.length;

    GskColorStop[] _tmpstops;
    foreach (obj; stops)
      _tmpstops ~= obj.cInstance;
    const(GskColorStop)* _stops = _tmpstops.ptr;
    gtk_snapshot_append_conic_gradient(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, center ? cast(graphene_point_t*)center.cPtr(false) : null, rotation, _stops, _nStops);
  }

  /**
   * A convenience method to fill a path with a color.
   * See [Gtk.Snapshot.pushFill] if you need
   * to fill a path with more complex content than
   * a color.
   * Params:
   *   path = The path describing the area to fill
   *   fillRule = The fill rule to use
   *   color = the color to fill the path with
   */
  void appendFill(Path path, FillRule fillRule, RGBA color)
  {
    gtk_snapshot_append_fill(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, fillRule, color ? cast(GdkRGBA*)color.cPtr(false) : null);
  }

  /**
   * Appends an inset shadow into the box given by outline.
   * Params:
   *   outline = outline of the region surrounded by shadow
   *   color = color of the shadow
   *   dx = horizontal offset of shadow
   *   dy = vertical offset of shadow
   *   spread = how far the shadow spreads towards the inside
   *   blurRadius = how much blur to apply to the shadow
   */
  void appendInsetShadow(RoundedRect outline, RGBA color, float dx, float dy, float spread, float blurRadius)
  {
    gtk_snapshot_append_inset_shadow(cast(GtkSnapshot*)cPtr, outline ? cast(GskRoundedRect*)outline.cPtr : null, color ? cast(GdkRGBA*)color.cPtr(false) : null, dx, dy, spread, blurRadius);
  }

  void appendLayout(Layout layout, RGBA color)
  {
    gtk_snapshot_append_layout(cast(GtkSnapshot*)cPtr, layout ? cast(PangoLayout*)layout.cPtr(false) : null, color ? cast(GdkRGBA*)color.cPtr(false) : null);
  }

  /**
   * Appends a linear gradient node with the given stops to snapshot.
   * Params:
   *   bounds = the rectangle to render the linear gradient into
   *   startPoint = the point at which the linear gradient will begin
   *   endPoint = the point at which the linear gradient will finish
   *   stops = the color stops defining the gradient
   */
  void appendLinearGradient(Rect bounds, Point startPoint, Point endPoint, ColorStop[] stops)
  {
    size_t _nStops;
    if (stops)
      _nStops = cast(size_t)stops.length;

    GskColorStop[] _tmpstops;
    foreach (obj; stops)
      _tmpstops ~= obj.cInstance;
    const(GskColorStop)* _stops = _tmpstops.ptr;
    gtk_snapshot_append_linear_gradient(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, startPoint ? cast(graphene_point_t*)startPoint.cPtr(false) : null, endPoint ? cast(graphene_point_t*)endPoint.cPtr(false) : null, _stops, _nStops);
  }

  /**
   * Appends node to the current render node of snapshot,
   * without changing the current node.
   * If snapshot does not have a current node yet, node
   * will become the initial node.
   * Params:
   *   node = a `GskRenderNode`
   */
  void appendNode(RenderNode node)
  {
    gtk_snapshot_append_node(cast(GtkSnapshot*)cPtr, node ? cast(GskRenderNode*)node.cPtr(false) : null);
  }

  /**
   * Appends an outset shadow node around the box given by outline.
   * Params:
   *   outline = outline of the region surrounded by shadow
   *   color = color of the shadow
   *   dx = horizontal offset of shadow
   *   dy = vertical offset of shadow
   *   spread = how far the shadow spreads towards the outside
   *   blurRadius = how much blur to apply to the shadow
   */
  void appendOutsetShadow(RoundedRect outline, RGBA color, float dx, float dy, float spread, float blurRadius)
  {
    gtk_snapshot_append_outset_shadow(cast(GtkSnapshot*)cPtr, outline ? cast(GskRoundedRect*)outline.cPtr : null, color ? cast(GdkRGBA*)color.cPtr(false) : null, dx, dy, spread, blurRadius);
  }

  /**
   * Appends a radial gradient node with the given stops to snapshot.
   * Params:
   *   bounds = the rectangle to render the readial gradient into
   *   center = the center point for the radial gradient
   *   hradius = the horizontal radius
   *   vradius = the vertical radius
   *   start = the start position $(LPAREN)on the horizontal axis$(RPAREN)
   *   end = the end position $(LPAREN)on the horizontal axis$(RPAREN)
   *   stops = the color stops defining the gradient
   */
  void appendRadialGradient(Rect bounds, Point center, float hradius, float vradius, float start, float end, ColorStop[] stops)
  {
    size_t _nStops;
    if (stops)
      _nStops = cast(size_t)stops.length;

    GskColorStop[] _tmpstops;
    foreach (obj; stops)
      _tmpstops ~= obj.cInstance;
    const(GskColorStop)* _stops = _tmpstops.ptr;
    gtk_snapshot_append_radial_gradient(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, center ? cast(graphene_point_t*)center.cPtr(false) : null, hradius, vradius, start, end, _stops, _nStops);
  }

  /**
   * Appends a repeating linear gradient node with the given stops to snapshot.
   * Params:
   *   bounds = the rectangle to render the linear gradient into
   *   startPoint = the point at which the linear gradient will begin
   *   endPoint = the point at which the linear gradient will finish
   *   stops = the color stops defining the gradient
   */
  void appendRepeatingLinearGradient(Rect bounds, Point startPoint, Point endPoint, ColorStop[] stops)
  {
    size_t _nStops;
    if (stops)
      _nStops = cast(size_t)stops.length;

    GskColorStop[] _tmpstops;
    foreach (obj; stops)
      _tmpstops ~= obj.cInstance;
    const(GskColorStop)* _stops = _tmpstops.ptr;
    gtk_snapshot_append_repeating_linear_gradient(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, startPoint ? cast(graphene_point_t*)startPoint.cPtr(false) : null, endPoint ? cast(graphene_point_t*)endPoint.cPtr(false) : null, _stops, _nStops);
  }

  /**
   * Appends a repeating radial gradient node with the given stops to snapshot.
   * Params:
   *   bounds = the rectangle to render the readial gradient into
   *   center = the center point for the radial gradient
   *   hradius = the horizontal radius
   *   vradius = the vertical radius
   *   start = the start position $(LPAREN)on the horizontal axis$(RPAREN)
   *   end = the end position $(LPAREN)on the horizontal axis$(RPAREN)
   *   stops = the color stops defining the gradient
   */
  void appendRepeatingRadialGradient(Rect bounds, Point center, float hradius, float vradius, float start, float end, ColorStop[] stops)
  {
    size_t _nStops;
    if (stops)
      _nStops = cast(size_t)stops.length;

    GskColorStop[] _tmpstops;
    foreach (obj; stops)
      _tmpstops ~= obj.cInstance;
    const(GskColorStop)* _stops = _tmpstops.ptr;
    gtk_snapshot_append_repeating_radial_gradient(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, center ? cast(graphene_point_t*)center.cPtr(false) : null, hradius, vradius, start, end, _stops, _nStops);
  }

  /**
   * Creates a new render node drawing the texture
   * into the given bounds and appends it to the
   * current render node of snapshot.
   * In contrast to [Gtk.Snapshot.appendTexture],
   * this function provides control about how the filter
   * that is used when scaling.
   * Params:
   *   texture = the texture to render
   *   filter = the filter to use
   *   bounds = the bounds for the new node
   */
  void appendScaledTexture(Texture texture, ScalingFilter filter, Rect bounds)
  {
    gtk_snapshot_append_scaled_texture(cast(GtkSnapshot*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(false) : null, filter, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
  }

  /**
   * A convenience method to stroke a path with a color.
   * See [Gtk.Snapshot.pushStroke] if you need
   * to stroke a path with more complex content than
   * a color.
   * Params:
   *   path = The path describing the area to fill
   *   stroke = The stroke attributes
   *   color = the color to fill the path with
   */
  void appendStroke(Path path, Stroke stroke, RGBA color)
  {
    gtk_snapshot_append_stroke(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, stroke ? cast(GskStroke*)stroke.cPtr(false) : null, color ? cast(GdkRGBA*)color.cPtr(false) : null);
  }

  /**
   * Creates a new render node drawing the texture
   * into the given bounds and appends it to the
   * current render node of snapshot.
   * If the texture needs to be scaled to fill bounds,
   * linear filtering is used. See [Gtk.Snapshot.appendScaledTexture]
   * if you need other filtering, such as nearest-neighbour.
   * Params:
   *   texture = the texture to render
   *   bounds = the bounds for the new node
   */
  void appendTexture(Texture texture, Rect bounds)
  {
    gtk_snapshot_append_texture(cast(GtkSnapshot*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(false) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
  }

  /**
   * Removes the top element from the stack of render nodes and
   * adds it to the nearest [Gsk.GLShaderNode] below it.
   * This must be called the same number of times as the number
   * of textures is needed for the shader in
   * [Gtk.Snapshot.pushGlShader].
   */
  void glShaderPopTexture()
  {
    gtk_snapshot_gl_shader_pop_texture(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Applies a perspective projection transform.
   * See [Gsk.Transform.perspective] for a discussion on the details.
   * Params:
   *   depth = distance of the z\=0 plane
   */
  void perspective(float depth)
  {
    gtk_snapshot_perspective(cast(GtkSnapshot*)cPtr, depth);
  }

  /**
   * Removes the top element from the stack of render nodes,
   * and appends it to the node underneath it.
   */
  void pop()
  {
    gtk_snapshot_pop(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Blends together two images with the given blend mode.
   * Until the first call to [Gtk.Snapshot.pop], the
   * bottom image for the blend operation will be recorded.
   * After that call, the top image to be blended will be
   * recorded until the second call to [Gtk.Snapshot.pop].
   * Calling this function requires two subsequent calls
   * to [Gtk.Snapshot.pop].
   * Params:
   *   blendMode = blend mode to use
   */
  void pushBlend(BlendMode blendMode)
  {
    gtk_snapshot_push_blend(cast(GtkSnapshot*)cPtr, blendMode);
  }

  /**
   * Blurs an image.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   radius = the blur radius to use. Must be positive
   */
  void pushBlur(double radius)
  {
    gtk_snapshot_push_blur(cast(GtkSnapshot*)cPtr, radius);
  }

  /**
   * Clips an image to a rectangle.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   bounds = the rectangle to clip to
   */
  void pushClip(Rect bounds)
  {
    gtk_snapshot_push_clip(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
  }

  /**
   * Modifies the colors of an image by applying an affine transformation
   * in RGB space.
   * In particular, the colors will be transformed by applying
   * pixel \= transpose$(LPAREN)color_matrix$(RPAREN) * pixel + color_offset
   * for every pixel. The transformation operates on unpremultiplied
   * colors, with color components ordered R, G, B, A.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   colorMatrix = the color matrix to use
   *   colorOffset = the color offset to use
   */
  void pushColorMatrix(Matrix colorMatrix, Vec4 colorOffset)
  {
    gtk_snapshot_push_color_matrix(cast(GtkSnapshot*)cPtr, colorMatrix ? cast(graphene_matrix_t*)colorMatrix.cPtr(false) : null, colorOffset ? cast(graphene_vec4_t*)colorOffset.cPtr(false) : null);
  }

  /**
   * Snapshots a cross-fade operation between two images with the
   * given progress.
   * Until the first call to [Gtk.Snapshot.pop], the start image
   * will be snapshot. After that call, the end image will be recorded
   * until the second call to [Gtk.Snapshot.pop].
   * Calling this function requires two subsequent calls
   * to [Gtk.Snapshot.pop].
   * Params:
   *   progress = progress between 0.0 and 1.0
   */
  void pushCrossFade(double progress)
  {
    gtk_snapshot_push_cross_fade(cast(GtkSnapshot*)cPtr, progress);
  }

  /**
   * Fills the area given by path and fill_rule with an image and discards everything
   * outside of it.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * If you want to fill the path with a color, [Gtk.Snapshot.appendFill]
   * may be more convenient.
   * Params:
   *   path = The path describing the area to fill
   *   fillRule = The fill rule to use
   */
  void pushFill(Path path, FillRule fillRule)
  {
    gtk_snapshot_push_fill(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, fillRule);
  }

  /**
   * Until the first call to [Gtk.Snapshot.pop], the
   * mask image for the mask operation will be recorded.
   * After that call, the source image will be recorded until
   * the second call to [Gtk.Snapshot.pop].
   * Calling this function requires 2 subsequent calls to [Gtk.Snapshot.pop].
   * Params:
   *   maskMode = mask mode to use
   */
  void pushMask(MaskMode maskMode)
  {
    gtk_snapshot_push_mask(cast(GtkSnapshot*)cPtr, maskMode);
  }

  /**
   * Modifies the opacity of an image.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   opacity = the opacity to use
   */
  void pushOpacity(double opacity)
  {
    gtk_snapshot_push_opacity(cast(GtkSnapshot*)cPtr, opacity);
  }

  /**
   * Creates a node that repeats the child node.
   * The child is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   bounds = the bounds within which to repeat
   *   childBounds = the bounds of the child or %NULL
   *     to use the full size of the collected child node
   */
  void pushRepeat(Rect bounds, Rect childBounds)
  {
    gtk_snapshot_push_repeat(cast(GtkSnapshot*)cPtr, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, childBounds ? cast(graphene_rect_t*)childBounds.cPtr(false) : null);
  }

  /**
   * Clips an image to a rounded rectangle.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   bounds = the rounded rectangle to clip to
   */
  void pushRoundedClip(RoundedRect bounds)
  {
    gtk_snapshot_push_rounded_clip(cast(GtkSnapshot*)cPtr, bounds ? cast(GskRoundedRect*)bounds.cPtr : null);
  }

  /**
   * Applies a shadow to an image.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Params:
   *   shadow = the first shadow specification
   */
  void pushShadow(Shadow[] shadow)
  {
    size_t _nShadows;
    if (shadow)
      _nShadows = cast(size_t)shadow.length;

    GskShadow[] _tmpshadow;
    foreach (obj; shadow)
      _tmpshadow ~= obj.cInstance;
    const(GskShadow)* _shadow = _tmpshadow.ptr;
    gtk_snapshot_push_shadow(cast(GtkSnapshot*)cPtr, _shadow, _nShadows);
  }

  /**
   * Strokes the given path with the attributes given by stroke and
   * an image.
   * The image is recorded until the next call to [Gtk.Snapshot.pop].
   * Note that the strokes are subject to the same transformation as
   * everything else, so uneven scaling will cause horizontal and vertical
   * strokes to have different widths.
   * If you want to stroke the path with a color, [Gtk.Snapshot.appendStroke]
   * may be more convenient.
   * Params:
   *   path = The path to stroke
   *   stroke = The stroke attributes
   */
  void pushStroke(Path path, Stroke stroke)
  {
    gtk_snapshot_push_stroke(cast(GtkSnapshot*)cPtr, path ? cast(GskPath*)path.cPtr(false) : null, stroke ? cast(GskStroke*)stroke.cPtr(false) : null);
  }

  /**
   * Creates a render node for the CSS background according to context,
   * and appends it to the current node of snapshot, without changing
   * the current node.
   * Params:
   *   context = the style context that defines the background
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   width = rectangle width
   *   height = rectangle height
   */
  void renderBackground(StyleContext context, double x, double y, double width, double height)
  {
    gtk_snapshot_render_background(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(false) : null, x, y, width, height);
  }

  /**
   * Creates a render node for the focus outline according to context,
   * and appends it to the current node of snapshot, without changing
   * the current node.
   * Params:
   *   context = the style context that defines the focus ring
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   width = rectangle width
   *   height = rectangle height
   */
  void renderFocus(StyleContext context, double x, double y, double width, double height)
  {
    gtk_snapshot_render_focus(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(false) : null, x, y, width, height);
  }

  /**
   * Creates a render node for the CSS border according to context,
   * and appends it to the current node of snapshot, without changing
   * the current node.
   * Params:
   *   context = the style context that defines the frame
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   width = rectangle width
   *   height = rectangle height
   */
  void renderFrame(StyleContext context, double x, double y, double width, double height)
  {
    gtk_snapshot_render_frame(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(false) : null, x, y, width, height);
  }

  /**
   * Draws a text caret using snapshot at the specified index of layout.
   * Params:
   *   context = a `GtkStyleContext`
   *   x = X origin
   *   y = Y origin
   *   layout = the `PangoLayout` of the text
   *   index = the index in the `PangoLayout`
   *   direction = the `PangoDirection` of the text
   */
  void renderInsertionCursor(StyleContext context, double x, double y, Layout layout, int index, Direction direction)
  {
    gtk_snapshot_render_insertion_cursor(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(false) : null, x, y, layout ? cast(PangoLayout*)layout.cPtr(false) : null, index, direction);
  }

  /**
   * Creates a render node for rendering layout according to the style
   * information in context, and appends it to the current node of snapshot,
   * without changing the current node.
   * Params:
   *   context = the style context that defines the text
   *   x = X origin of the rectangle
   *   y = Y origin of the rectangle
   *   layout = the `PangoLayout` to render
   */
  void renderLayout(StyleContext context, double x, double y, Layout layout)
  {
    gtk_snapshot_render_layout(cast(GtkSnapshot*)cPtr, context ? cast(GtkStyleContext*)context.cPtr(false) : null, x, y, layout ? cast(PangoLayout*)layout.cPtr(false) : null);
  }

  /**
   * Restores snapshot to the state saved by a preceding call to
   * [Gtk.Snapshot.save] and removes that state from the stack of
   * saved states.
   */
  void restore()
  {
    gtk_snapshot_restore(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Rotates @snapshot's coordinate system by angle degrees in 2D space -
   * or in 3D speak, rotates around the Z axis. The rotation happens around
   * the origin point of $(LPAREN)0, 0$(RPAREN) in the snapshot's current coordinate system.
   * To rotate around axes other than the Z axis, use [Gsk.Transform.rotate3d].
   * Params:
   *   angle = the rotation angle, in degrees $(LPAREN)clockwise$(RPAREN)
   */
  void rotate(float angle)
  {
    gtk_snapshot_rotate(cast(GtkSnapshot*)cPtr, angle);
  }

  /**
   * Rotates snapshot's coordinate system by angle degrees around axis.
   * For a rotation in 2D space, use [Gsk.Transform.rotate].
   * Params:
   *   angle = the rotation angle, in degrees $(LPAREN)clockwise$(RPAREN)
   *   axis = The rotation axis
   */
  void rotate3d(float angle, Vec3 axis)
  {
    gtk_snapshot_rotate_3d(cast(GtkSnapshot*)cPtr, angle, axis ? cast(graphene_vec3_t*)axis.cPtr(false) : null);
  }

  /**
   * Makes a copy of the current state of snapshot and saves it
   * on an internal stack.
   * When [Gtk.Snapshot.restore] is called, snapshot will
   * be restored to the saved state.
   * Multiple calls to [Gtk.Snapshot.save] and [Gtk.Snapshot.restore]
   * can be nested; each call to `[Gtk.Snapshot.restore]` restores the state from
   * the matching paired `[Gtk.Snapshot.save]`.
   * It is necessary to clear all saved states with corresponding
   * calls to `[Gtk.Snapshot.restore]`.
   */
  void save()
  {
    gtk_snapshot_save(cast(GtkSnapshot*)cPtr);
  }

  /**
   * Scales snapshot's coordinate system in 2-dimensional space by
   * the given factors.
   * Use [Gtk.Snapshot.scale3d] to scale in all 3 dimensions.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   */
  void scale(float factorX, float factorY)
  {
    gtk_snapshot_scale(cast(GtkSnapshot*)cPtr, factorX, factorY);
  }

  /**
   * Scales snapshot's coordinate system by the given factors.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   *   factorZ = scaling factor on the Z axis
   */
  void scale3d(float factorX, float factorY, float factorZ)
  {
    gtk_snapshot_scale_3d(cast(GtkSnapshot*)cPtr, factorX, factorY, factorZ);
  }

  /**
   * Returns the render node that was constructed
   * by snapshot.
   * Note that this function may return %NULL if nothing has been
   * added to the snapshot or if its content does not produce pixels
   * to be rendered.
   * After calling this function, it is no longer possible to
   * add more nodes to snapshot. The only function that should
   * be called after this is [GObject.ObjectG.unref].
   * Returns: the constructed `GskRenderNode` or
   *   %NULL if there are no nodes to render.
   */
  RenderNode toNode()
  {
    GskRenderNode* _cretval;
    _cretval = gtk_snapshot_to_node(cast(GtkSnapshot*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a paintable encapsulating the render node
   * that was constructed by snapshot.
   * After calling this function, it is no longer possible to
   * add more nodes to snapshot. The only function that should
   * be called after this is [GObject.ObjectG.unref].
   * Params:
   *   size = The size of the resulting paintable
   *     or %NULL to use the bounds of the snapshot
   * Returns: a new `GdkPaintable`
   */
  Paintable toPaintable(Size size)
  {
    GdkPaintable* _cretval;
    _cretval = gtk_snapshot_to_paintable(cast(GtkSnapshot*)cPtr, size ? cast(graphene_size_t*)size.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Transforms snapshot's coordinate system with the given transform.
   * Params:
   *   transform = the transform to apply
   */
  void transform(Transform transform)
  {
    gtk_snapshot_transform(cast(GtkSnapshot*)cPtr, transform ? cast(GskTransform*)transform.cPtr(false) : null);
  }

  /**
   * Transforms snapshot's coordinate system with the given matrix.
   * Params:
   *   matrix = the matrix to multiply the transform with
   */
  void transformMatrix(Matrix matrix)
  {
    gtk_snapshot_transform_matrix(cast(GtkSnapshot*)cPtr, matrix ? cast(graphene_matrix_t*)matrix.cPtr(false) : null);
  }

  /**
   * Translates snapshot's coordinate system by point in 2-dimensional space.
   * Params:
   *   point = the point to translate the snapshot by
   */
  void translate(Point point)
  {
    gtk_snapshot_translate(cast(GtkSnapshot*)cPtr, point ? cast(graphene_point_t*)point.cPtr(false) : null);
  }

  /**
   * Translates snapshot's coordinate system by point.
   * Params:
   *   point = the point to translate the snapshot by
   */
  void translate3d(Point3D point)
  {
    gtk_snapshot_translate_3d(cast(GtkSnapshot*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
  }
}
