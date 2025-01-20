module Gdk.GLContext;

import GLib.ErrorG;
import GObject.ObjectG;
import Gdk.Display;
import Gdk.DrawContext;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * `GdkGLContext` is an object representing a platform-specific
 * OpenGL draw context.
 * `GdkGLContext`s are created for a surface using
 * [Gdk.Surface.createGlContext], and the context will match
 * the characteristics of the surface.
 * A `GdkGLContext` is not tied to any particular normal framebuffer.
 * For instance, it cannot draw to the surface back buffer. The GDK
 * repaint system is in full control of the painting to that. Instead,
 * you can create render buffers or textures and use func@cairo_draw_from_gl
 * in the draw function of your widget to draw them. Then GDK will handle
 * the integration of your rendering with that of other widgets.
 * Support for `GdkGLContext` is platform-specific and context creation
 * can fail, returning %NULL context.
 * A `GdkGLContext` has to be made "current" in order to start using
 * it, otherwise any OpenGL call will be ignored.
 * ## Creating a new OpenGL context
 * In order to create a new `GdkGLContext` instance you need a `GdkSurface`,
 * which you typically get during the realize call of a widget.
 * A `GdkGLContext` is not realized until either [Gdk.GLContext.makeCurrent]
 * or [Gdk.GLContext.realize] is called. It is possible to specify
 * details of the GL context like the OpenGL version to be used, or whether
 * the GL context should have extra state validation enabled after calling
 * [Gdk.Surface.createGlContext] by calling [Gdk.GLContext.realize].
 * If the realization fails you have the option to change the settings of
 * the `GdkGLContext` and try again.
 * ## Using a GdkGLContext
 * You will need to make the `GdkGLContext` the current context before issuing
 * OpenGL calls; the system sends OpenGL commands to whichever context is current.
 * It is possible to have multiple contexts, so you always need to ensure that
 * the one which you want to draw with is the current one before issuing commands:
 * ```c
 * gdk_gl_context_make_current $(LPAREN)context$(RPAREN);
 * ```
 * You can now perform your drawing using OpenGL commands.
 * You can check which `GdkGLContext` is the current one by using
 * [Gdk.GLContext.getCurrent]; you can also unset any `GdkGLContext`
 * that is currently set by calling [Gdk.GLContext.clearCurrent].
 */
class GLContext : DrawContext
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gdk_gl_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Clears the current `GdkGLContext`.
   * Any OpenGL call after this function returns will be ignored
   * until [Gdk.GLContext.makeCurrent] is called.
   */
  static void clearCurrent()
  {
    gdk_gl_context_clear_current();
  }

  /**
   * Retrieves the current `GdkGLContext`.
   * Returns: the current `GdkGLContext`
   */
  static GLContext getCurrent()
  {
    GdkGLContext* _cretval;
    _cretval = gdk_gl_context_get_current();
    auto _retval = _cretval ? ObjectG.getDObject!GLContext(cast(GdkGLContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the allowed APIs set via [Gdk.GLContext.setAllowedApis].
   * Returns: the allowed APIs
   */
  GLAPI getAllowedApis()
  {
    GdkGLAPI _cretval;
    _cretval = gdk_gl_context_get_allowed_apis(cast(GdkGLContext*)cPtr);
    GLAPI _retval = cast(GLAPI)_cretval;
    return _retval;
  }

  /**
   * Gets the API currently in use.
   * If the renderer has not been realized yet, 0 is returned.
   * Returns: the currently used API
   */
  GLAPI getApi()
  {
    GdkGLAPI _cretval;
    _cretval = gdk_gl_context_get_api(cast(GdkGLContext*)cPtr);
    GLAPI _retval = cast(GLAPI)_cretval;
    return _retval;
  }

  /**
   * Retrieves whether the context is doing extra validations and runtime checking.
   * See [Gdk.GLContext.setDebugEnabled].
   * Returns: %TRUE if debugging is enabled
   */
  bool getDebugEnabled()
  {
    bool _retval;
    _retval = gdk_gl_context_get_debug_enabled(cast(GdkGLContext*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the display the context is created for
   * Returns: a `GdkDisplay`
   */
  override Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_gl_context_get_display(cast(GdkGLContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves whether the context is forward-compatible.
   * See [Gdk.GLContext.setForwardCompatible].
   * Returns: %TRUE if the context should be forward-compatible
   */
  bool getForwardCompatible()
  {
    bool _retval;
    _retval = gdk_gl_context_get_forward_compatible(cast(GdkGLContext*)cPtr);
    return _retval;
  }

  /**
   * Retrieves required OpenGL version set as a requirement for the context
   * realization. It will not change even if a greater OpenGL version is supported
   * and used after the context is realized. See
   * [Gdk.GLContext.getVersion] for the real version in use.
   * See [Gdk.GLContext.setRequiredVersion].
   * Params:
   *   major = return location for the major version to request
   *   minor = return location for the minor version to request
   */
  void getRequiredVersion(out int major, out int minor)
  {
    gdk_gl_context_get_required_version(cast(GdkGLContext*)cPtr, cast(int*)&major, cast(int*)&minor);
  }

  /**
   * Used to retrieves the `GdkGLContext` that this context share data with.
   * As many contexts can share data now and no single shared context exists
   * anymore, this function has been deprecated and now always returns %NULL.
   * Returns: %NULL

   * Deprecated: Use [Gdk.GLContext.isShared] to check if contexts
   *   can be shared.
   */
  GLContext getSharedContext()
  {
    GdkGLContext* _cretval;
    _cretval = gdk_gl_context_get_shared_context(cast(GdkGLContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!GLContext(cast(GdkGLContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the surface used by the context.
   * Returns: a `GdkSurface`
   */
  override Surface getSurface()
  {
    GdkSurface* _cretval;
    _cretval = gdk_gl_context_get_surface(cast(GdkGLContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the context is using an OpenGL or OpenGL ES profile.
   * Returns: %TRUE if the `GdkGLContext` is using an OpenGL ES profile;
   *   %FALSE if other profile is in use of if the context has not yet
   *   been realized.
   */
  bool getUseEs()
  {
    bool _retval;
    _retval = gdk_gl_context_get_use_es(cast(GdkGLContext*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the OpenGL version of the context.
   * The context must be realized prior to calling this function.
   * Params:
   *   major = return location for the major version
   *   minor = return location for the minor version
   */
  void getVersion(out int major, out int minor)
  {
    gdk_gl_context_get_version(cast(GdkGLContext*)cPtr, cast(int*)&major, cast(int*)&minor);
  }

  /**
   * Whether the `GdkGLContext` is in legacy mode or not.
   * The `GdkGLContext` must be realized before calling this function.
   * When realizing a GL context, GDK will try to use the OpenGL 3.2 core
   * profile; this profile removes all the OpenGL API that was deprecated
   * prior to the 3.2 version of the specification. If the realization is
   * successful, this function will return %FALSE.
   * If the underlying OpenGL implementation does not support core profiles,
   * GDK will fall back to a pre-3.2 compatibility profile, and this function
   * will return %TRUE.
   * You can use the value returned by this function to decide which kind
   * of OpenGL API to use, or whether to do extension discovery, or what
   * kind of shader programs to load.
   * Returns: %TRUE if the GL context is in legacy mode
   */
  bool isLegacy()
  {
    bool _retval;
    _retval = gdk_gl_context_is_legacy(cast(GdkGLContext*)cPtr);
    return _retval;
  }

  /**
   * Checks if the two GL contexts can share resources.
   * When they can, the texture IDs from other can be used in self. This
   * is particularly useful when passing `GdkGLTexture` objects between
   * different contexts.
   * Contexts created for the same display with the same properties will
   * always be compatible, even if they are created for different surfaces.
   * For other contexts it depends on the GL backend.
   * Both contexts must be realized for this check to succeed. If either one
   * is not, this function will return %FALSE.
   * Params:
   *   other = the `GdkGLContext` that should be compatible with self
   * Returns: %TRUE if the two GL contexts are compatible.
   */
  bool isShared(GLContext other)
  {
    bool _retval;
    _retval = gdk_gl_context_is_shared(cast(GdkGLContext*)cPtr, other ? cast(GdkGLContext*)other.cPtr(false) : null);
    return _retval;
  }

  /**
   * Makes the context the current one.
   */
  void makeCurrent()
  {
    gdk_gl_context_make_current(cast(GdkGLContext*)cPtr);
  }

  /**
   * Realizes the given `GdkGLContext`.
   * It is safe to call this function on a realized `GdkGLContext`.
   * Returns: %TRUE if the context is realized
   */
  bool realize()
  {
    bool _retval;
    GError *_err;
    _retval = gdk_gl_context_realize(cast(GdkGLContext*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the allowed APIs. When [Gdk.GLContext.realize] is called, only the
   * allowed APIs will be tried. If you set this to 0, realizing will always fail.
   * If you set it on a realized context, the property will not have any effect.
   * It is only relevant during [Gdk.GLContext.realize].
   * By default, all APIs are allowed.
   * Params:
   *   apis = the allowed APIs
   */
  void setAllowedApis(GLAPI apis)
  {
    gdk_gl_context_set_allowed_apis(cast(GdkGLContext*)cPtr, apis);
  }

  /**
   * Sets whether the `GdkGLContext` should perform extra validations and
   * runtime checking.
   * This is useful during development, but has additional overhead.
   * The `GdkGLContext` must not be realized or made current prior to
   * calling this function.
   * Params:
   *   enabled = whether to enable debugging in the context
   */
  void setDebugEnabled(bool enabled)
  {
    gdk_gl_context_set_debug_enabled(cast(GdkGLContext*)cPtr, enabled);
  }

  /**
   * Sets whether the `GdkGLContext` should be forward-compatible.
   * Forward-compatible contexts must not support OpenGL functionality that
   * has been marked as deprecated in the requested version; non-forward
   * compatible contexts, on the other hand, must support both deprecated and
   * non deprecated functionality.
   * The `GdkGLContext` must not be realized or made current prior to calling
   * this function.
   * Params:
   *   compatible = whether the context should be forward-compatible
   */
  void setForwardCompatible(bool compatible)
  {
    gdk_gl_context_set_forward_compatible(cast(GdkGLContext*)cPtr, compatible);
  }

  /**
   * Sets the major and minor version of OpenGL to request.
   * Setting major and minor to zero will use the default values.
   * Setting major and minor lower than the minimum versions required
   * by GTK will result in the context choosing the minimum version.
   * The context must not be realized or made current prior to calling
   * this function.
   * Params:
   *   major = the major version to request
   *   minor = the minor version to request
   */
  void setRequiredVersion(int major, int minor)
  {
    gdk_gl_context_set_required_version(cast(GdkGLContext*)cPtr, major, minor);
  }

  /**
   * Requests that GDK create an OpenGL ES context instead of an OpenGL one.
   * Not all platforms support OpenGL ES.
   * The context must not have been realized.
   * By default, GDK will attempt to automatically detect whether the
   * underlying GL implementation is OpenGL or OpenGL ES once the context
   * is realized.
   * You should check the return value of [Gdk.GLContext.getUseEs]
   * after calling [Gdk.GLContext.realize] to decide whether to use
   * the OpenGL or OpenGL ES API, extensions, or shaders.
   * Params:
   *   useEs = whether the context should use OpenGL ES instead of OpenGL,
   *     or -1 to allow auto-detection
   */
  void setUseEs(int useEs)
  {
    gdk_gl_context_set_use_es(cast(GdkGLContext*)cPtr, useEs);
  }
}
