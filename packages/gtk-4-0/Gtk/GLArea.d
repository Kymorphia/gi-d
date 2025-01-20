module Gtk.GLArea;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gdk.GLContext;
import Gdk.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGLArea` is a widget that allows drawing with OpenGL.
 * ![An example GtkGLArea](glarea.png)
 * `GtkGLArea` sets up its own [Gdk.GLContext], and creates a custom
 * GL framebuffer that the widget will do GL rendering onto. It also ensures
 * that this framebuffer is the default GL rendering target when rendering.
 * The completed rendering is integrated into the larger GTK scene graph as
 * a texture.
 * In order to draw, you have to connect to the [Gtk.GLArea.render]
 * signal, or subclass `GtkGLArea` and override the GtkGLAreaClass.render
 * virtual function.
 * The `GtkGLArea` widget ensures that the `GdkGLContext` is associated with
 * the widget's drawing area, and it is kept updated when the size and
 * position of the drawing area changes.
 * ## Drawing with GtkGLArea
 * The simplest way to draw using OpenGL commands in a `GtkGLArea` is to
 * create a widget instance and connect to the [Gtk.GLArea.render] signal:
 * The `render$(LPAREN)$(RPAREN)` function will be called when the `GtkGLArea` is ready
 * for you to draw its content:
 * The initial contents of the framebuffer are transparent.
 * ```c
 * static gboolean
 * render $(LPAREN)GtkGLArea *area, GdkGLContext *context$(RPAREN)
 * {
 * // inside this function it's safe to use GL; the given
 * // GdkGLContext has been made current to the drawable
 * // surface used by the `GtkGLArea` and the viewport has
 * // already been set to be the size of the allocation
 * // we can start by clearing the buffer
 * glClearColor $(LPAREN)0, 0, 0, 0$(RPAREN);
 * glClear $(LPAREN)GL_COLOR_BUFFER_BIT$(RPAREN);
 * // draw your object
 * // draw_an_object $(LPAREN)$(RPAREN);
 * // we completed our drawing; the draw commands will be
 * // flushed at the end of the signal emission chain, and
 * // the buffers will be drawn on the window
 * return TRUE;
 * }
 * void setup_glarea $(LPAREN)void$(RPAREN)
 * {
 * // create a GtkGLArea instance
 * GtkWidget *gl_area \= gtk_gl_area_new $(LPAREN)$(RPAREN);
 * // connect to the "render" signal
 * g_signal_connect $(LPAREN)gl_area, "render", G_CALLBACK $(LPAREN)render$(RPAREN), NULL$(RPAREN);
 * }
 * ```
 * If you need to initialize OpenGL state, e.g. buffer objects or
 * shaders, you should use the [Gtk.Widget.realize] signal;
 * you can use the [Gtk.Widget.unrealize] signal to clean up.
 * Since the `GdkGLContext` creation and initialization may fail, you
 * will need to check for errors, using [Gtk.GLArea.getError].
 * An example of how to safely initialize the GL state is:
 * ```c
 * static void
 * on_realize $(LPAREN)GtkGLarea *area$(RPAREN)
 * {
 * // We need to make the context current if we want to
 * // call GL API
 * gtk_gl_area_make_current $(LPAREN)area$(RPAREN);
 * // If there were errors during the initialization or
 * // when trying to make the context current, this
 * // function will return a GError for you to catch
 * if $(LPAREN)gtk_gl_area_get_error $(LPAREN)area$(RPAREN) !\= NULL$(RPAREN)
 * return;
 * // You can also use [Gtk.GLArea.setError] in order
 * // to show eventual initialization errors on the
 * // GtkGLArea widget itself
 * GError *internal_error \= NULL;
 * init_buffer_objects $(LPAREN)&error$(RPAREN);
 * if $(LPAREN)error !\= NULL$(RPAREN)
 * {
 * gtk_gl_area_set_error $(LPAREN)area, error$(RPAREN);
 * g_error_free $(LPAREN)error$(RPAREN);
 * return;
 * }
 * init_shaders $(LPAREN)&error$(RPAREN);
 * if $(LPAREN)error !\= NULL$(RPAREN)
 * {
 * gtk_gl_area_set_error $(LPAREN)area, error$(RPAREN);
 * g_error_free $(LPAREN)error$(RPAREN);
 * return;
 * }
 * }
 * ```
 * If you need to change the options for creating the `GdkGLContext`
 * you should use the signal@Gtk.GLArea::create-context signal.
 */
class GLArea : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_gl_area_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkGLArea` widget.
   * Returns: a new `GtkGLArea`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_gl_area_new();
    this(_cretval, false);
  }

  /**
   * Binds buffers to the framebuffer.
   * Ensures that the area framebuffer object is made the current draw
   * and read target, and that all the required buffers for the area
   * are created and bound to the framebuffer.
   * This function is automatically called before emitting the
   * [Gtk.GLArea.render] signal, and doesn't normally need to be
   * called by application code.
   */
  void attachBuffers()
  {
    gtk_gl_area_attach_buffers(cast(GtkGLArea*)cPtr);
  }

  /**
   * Gets the allowed APIs.
   * See [Gtk.GLArea.setAllowedApis].
   * Returns: the allowed APIs
   */
  GLAPI getAllowedApis()
  {
    GdkGLAPI _cretval;
    _cretval = gtk_gl_area_get_allowed_apis(cast(GtkGLArea*)cPtr);
    GLAPI _retval = cast(GLAPI)_cretval;
    return _retval;
  }

  /**
   * Gets the API that is currently in use.
   * If the GL area has not been realized yet, 0 is returned.
   * Returns: the currently used API
   */
  GLAPI getApi()
  {
    GdkGLAPI _cretval;
    _cretval = gtk_gl_area_get_api(cast(GtkGLArea*)cPtr);
    GLAPI _retval = cast(GLAPI)_cretval;
    return _retval;
  }

  /**
   * Returns whether the area is in auto render mode or not.
   * Returns: %TRUE if the area is auto rendering, %FALSE otherwise
   */
  bool getAutoRender()
  {
    bool _retval;
    _retval = gtk_gl_area_get_auto_render(cast(GtkGLArea*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the `GdkGLContext` used by area.
   * Returns: the `GdkGLContext`
   */
  GLContext getContext()
  {
    GdkGLContext* _cretval;
    _cretval = gtk_gl_area_get_context(cast(GtkGLArea*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!GLContext(cast(GdkGLContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current error set on the area.
   * Returns: the `GError`
   */
  ErrorG getError()
  {
    GError* _cretval;
    _cretval = gtk_gl_area_get_error(cast(GtkGLArea*)cPtr);
    auto _retval = _cretval ? new ErrorG(cast(GError*)_cretval) : null;
    return _retval;
  }

  /**
   * Returns whether the area has a depth buffer.
   * Returns: %TRUE if the area has a depth buffer, %FALSE otherwise
   */
  bool getHasDepthBuffer()
  {
    bool _retval;
    _retval = gtk_gl_area_get_has_depth_buffer(cast(GtkGLArea*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the area has a stencil buffer.
   * Returns: %TRUE if the area has a stencil buffer, %FALSE otherwise
   */
  bool getHasStencilBuffer()
  {
    bool _retval;
    _retval = gtk_gl_area_get_has_stencil_buffer(cast(GtkGLArea*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the required version of OpenGL.
   * See [Gtk.GLArea.setRequiredVersion].
   * Params:
   *   major = return location for the required major version
   *   minor = return location for the required minor version
   */
  void getRequiredVersion(out int major, out int minor)
  {
    gtk_gl_area_get_required_version(cast(GtkGLArea*)cPtr, cast(int*)&major, cast(int*)&minor);
  }

  /**
   * Returns whether the `GtkGLArea` should use OpenGL ES.
   * See [Gtk.GLArea.setUseEs].
   * Returns: %TRUE if the `GtkGLArea` should create an OpenGL ES context
   *   and %FALSE otherwise

   * Deprecated: Use [Gtk.GLArea.getApi]
   */
  bool getUseEs()
  {
    bool _retval;
    _retval = gtk_gl_area_get_use_es(cast(GtkGLArea*)cPtr);
    return _retval;
  }

  /**
   * Ensures that the `GdkGLContext` used by area is associated with
   * the `GtkGLArea`.
   * This function is automatically called before emitting the
   * [Gtk.GLArea.render] signal, and doesn't normally need
   * to be called by application code.
   */
  void makeCurrent()
  {
    gtk_gl_area_make_current(cast(GtkGLArea*)cPtr);
  }

  /**
   * Marks the currently rendered data $(LPAREN)if any$(RPAREN) as invalid, and queues
   * a redraw of the widget.
   * This ensures that the [Gtk.GLArea.render] signal
   * is emitted during the draw.
   * This is only needed when [Gtk.GLArea.setAutoRender] has
   * been called with a %FALSE value. The default behaviour is to
   * emit [Gtk.GLArea.render] on each draw.
   */
  void queueRender()
  {
    gtk_gl_area_queue_render(cast(GtkGLArea*)cPtr);
  }

  /**
   * Sets the allowed APIs to create a context with.
   * You should check [Gtk.GLArea.api] before drawing
   * with either API.
   * By default, all APIs are allowed.
   * Params:
   *   apis = the allowed APIs
   */
  void setAllowedApis(GLAPI apis)
  {
    gtk_gl_area_set_allowed_apis(cast(GtkGLArea*)cPtr, apis);
  }

  /**
   * Sets whether the `GtkGLArea` is in auto render mode.
   * If auto_render is %TRUE the [Gtk.GLArea.render] signal will
   * be emitted every time the widget draws. This is the default and is
   * useful if drawing the widget is faster.
   * If auto_render is %FALSE the data from previous rendering is kept
   * around and will be used for drawing the widget the next time,
   * unless the window is resized. In order to force a rendering
   * [Gtk.GLArea.queueRender] must be called. This mode is
   * useful when the scene changes seldom, but takes a long time to redraw.
   * Params:
   *   autoRender = a boolean
   */
  void setAutoRender(bool autoRender)
  {
    gtk_gl_area_set_auto_render(cast(GtkGLArea*)cPtr, autoRender);
  }

  /**
   * Sets an error on the area which will be shown instead of the
   * GL rendering.
   * This is useful in the signalGtk.GLArea::create-context
   * signal if GL context creation fails.
   * Params:
   *   error = a new `GError`, or %NULL to unset the error
   */
  void setError(ErrorG error)
  {
    gtk_gl_area_set_error(cast(GtkGLArea*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Sets whether the `GtkGLArea` should use a depth buffer.
   * If has_depth_buffer is %TRUE the widget will allocate and
   * enable a depth buffer for the target framebuffer. Otherwise
   * there will be none.
   * Params:
   *   hasDepthBuffer = %TRUE to add a depth buffer
   */
  void setHasDepthBuffer(bool hasDepthBuffer)
  {
    gtk_gl_area_set_has_depth_buffer(cast(GtkGLArea*)cPtr, hasDepthBuffer);
  }

  /**
   * Sets whether the `GtkGLArea` should use a stencil buffer.
   * If has_stencil_buffer is %TRUE the widget will allocate and
   * enable a stencil buffer for the target framebuffer. Otherwise
   * there will be none.
   * Params:
   *   hasStencilBuffer = %TRUE to add a stencil buffer
   */
  void setHasStencilBuffer(bool hasStencilBuffer)
  {
    gtk_gl_area_set_has_stencil_buffer(cast(GtkGLArea*)cPtr, hasStencilBuffer);
  }

  /**
   * Sets the required version of OpenGL to be used when creating
   * the context for the widget.
   * This function must be called before the area has been realized.
   * Params:
   *   major = the major version
   *   minor = the minor version
   */
  void setRequiredVersion(int major, int minor)
  {
    gtk_gl_area_set_required_version(cast(GtkGLArea*)cPtr, major, minor);
  }

  /**
   * Sets whether the area should create an OpenGL or an OpenGL ES context.
   * You should check the capabilities of the `GdkGLContext` before drawing
   * with either API.
   * Params:
   *   useEs = whether to use OpenGL or OpenGL ES

   * Deprecated: Use [Gtk.GLArea.setAllowedApis]
   */
  void setUseEs(bool useEs)
  {
    gtk_gl_area_set_use_es(cast(GtkGLArea*)cPtr, useEs);
  }

  /**
   * Emitted when the widget is being realized.
   * This allows you to override how the GL context is created.
   * This is useful when you want to reuse an existing GL context,
   * or if you want to try creating different kinds of GL options.
   * If context creation fails then the signal handler can use
   * [Gtk.GLArea.setError] to register a more detailed error
   * of how the construction failed.
   *   gLArea = the instance the signal is connected to
   * Returns: a newly created `GdkGLContext`;
   *   the `GtkGLArea` widget will take ownership of the returned value.
   */
  alias CreateContextCallback = GLContext delegate(GLArea gLArea);

  /**
   * Connect to CreateContext signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCreateContext(CreateContextCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gLArea = getVal!GLArea(_paramVals);
      auto _retval = _dgClosure.dlg(gLArea);
      setVal!GLContext(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("create-context", closure, after);
  }

  /**
   * Emitted every time the contents of the `GtkGLArea` should be redrawn.
   * The context is bound to the area prior to emitting this function,
   * and the buffers are painted to the window once the emission terminates.
   * Params
   *   context = the `GdkGLContext` used by area
   *   gLArea = the instance the signal is connected to
   * Returns: %TRUE to stop other handlers from being invoked for the event.
   *   %FALSE to propagate the event further.
   */
  alias RenderCallback = bool delegate(GLContext context, GLArea gLArea);

  /**
   * Connect to Render signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRender(RenderCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto gLArea = getVal!GLArea(_paramVals);
      auto context = getVal!GLContext(&_paramVals[1]);
      _retval = _dgClosure.dlg(context, gLArea);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("render", closure, after);
  }

  /**
   * Emitted once when the widget is realized, and then each time the widget
   * is changed while realized.
   * This is useful in order to keep GL state up to date with the widget size,
   * like for instance camera properties which may depend on the width/height
   * ratio.
   * The GL context for the area is guaranteed to be current when this signal
   * is emitted.
   * The default handler sets up the GL viewport.
   * Params
   *   width = the width of the viewport
   *   height = the height of the viewport
   *   gLArea = the instance the signal is connected to
   */
  alias ResizeCallback = void delegate(int width, int height, GLArea gLArea);

  /**
   * Connect to Resize signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectResize(ResizeCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gLArea = getVal!GLArea(_paramVals);
      auto width = getVal!int(&_paramVals[1]);
      auto height = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(width, height, gLArea);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("resize", closure, after);
  }
}
