module Gdk.CairoContext;

import Gdk.DrawContext;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import cairo.Context;

/**
 * `GdkCairoContext` is an object representing the platform-specific
 * draw context.
 * `GdkCairoContext`s are created for a surface using
 * [Gdk.Surface.createCairoContext], and the context
 * can then be used to draw on that surface.
 */
class CairoContext : DrawContext
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
    return gdk_cairo_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves a Cairo context to be used to draw on the `GdkSurface`
   * of context.
   * A call to [Gdk.DrawContext.beginFrame] with this
   * context must have been done or this function will return %NULL.
   * The returned context is guaranteed to be valid until
   * [Gdk.DrawContext.endFrame] is called.
   * Returns: a Cairo context
   *   to draw on `GdkSurface
   */
  Context cairoCreate()
  {
    cairo_t* _cretval;
    _cretval = gdk_cairo_context_cairo_create(cast(GdkCairoContext*)cPtr);
    auto _retval = _cretval ? new Context(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
