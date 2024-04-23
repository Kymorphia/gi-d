module Gio.Initable;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Parameter;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GInitable is implemented by objects that can fail during
 * initialization. If an object implements this interface then
 * it must be initialized as the first thing after construction,
 * either via g_initable_init() or g_async_initable_init_async()
 * (the latter is only available if it also implements #GAsyncInitable).
 *
 * If the object is not initialized, or initialization returns with an
 * error, then all operations on the object except g_object_ref() and
 * g_object_unref() are considered to be invalid, and have undefined
 * behaviour. They will often fail with g_critical() or g_warning(), but
 * this must not be relied on.
 *
 * Users of objects implementing this are not intended to use
 * the interface method directly, instead it will be used automatically
 * in various ways. For C applications you generally just call
 * g_initable_new() directly, or indirectly via a foo_thing_new() wrapper.
 * This will call g_initable_init() under the cover, returning %NULL and
 * setting a #GError on failure (at which point the instance is
 * unreferenced).
 *
 * For bindings in languages where the native constructor supports
 * exceptions the binding could check for objects implementing %GInitable
 * during normal construction and automatically initialize them, throwing
 * an exception on failure.
 */
interface Initable
{

  static GType getType()
  {
    return g_initable_get_type();
  }

  /**
   * a newly allocated
   * #GObject, or %NULL on error
   */
  static ObjectG newv(GType objectType, Parameter[] parameters, Cancellable cancellable);

  /**
   * %TRUE if successful. If an error has occurred, this function will
   * return %FALSE and set @error appropriately if present.
   */
  bool init_(Cancellable cancellable);
}
