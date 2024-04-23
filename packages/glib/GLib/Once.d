module GLib.Once;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A #GOnce struct controls a one-time initialization function. Any
 * one-time initialization function must have its own unique #GOnce
 * struct.
 */
class Once
{
  GOnce cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Once");

    cInstance = *cast(GOnce*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GOnce))
  {
    return cast(T*)&cInstance;
  }

  @property OnceStatus status()
  {
    return cast(OnceStatus)cPtr!GOnce.status;
  }

  @property void status(OnceStatus propval)
  {
    cPtr!GOnce.status = cast(GOnceStatus)propval;
  }

  /**
   * %TRUE if the initialization section should be entered,
   * %FALSE and blocks otherwise
   */
  static bool initEnter(void* location)
  {
    bool _retval;
    _retval = g_once_init_enter(location);
    return _retval;
  }

  /**
   * Counterpart to g_once_init_enter(). Expects a location of a static
   * 0-initialized initialization variable, and an initialization value
   * other than 0. Sets the variable to the initialization value, and
   * releases concurrent threads blocking in g_once_init_enter() on this
   * initialization variable.
   *
   * While @location has a `volatile` qualifier, this is a historical artifact and
   * the pointer passed to it should not be `volatile`.
   */
  static void initLeave(void* location, size_t result)
  {
    g_once_init_leave(location, result);
  }
}
