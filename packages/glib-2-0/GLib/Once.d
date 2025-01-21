module GLib.Once;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property OnceStatus status()
  {
    return cast(OnceStatus)(cast(GOnce*)cPtr).status;
  }

  @property void status(OnceStatus propval)
  {
    (cast(GOnce*)cPtr).status = cast(GOnceStatus)propval;
  }

  /**
   * Function to be called when starting a critical initialization
   * section. The argument location must point to a static
   * 0-initialized variable that will be set to a value other than 0 at
   * the end of the initialization section. In combination with
   * [GLib.Once.initLeave] and the unique address value_location, it can
   * be ensured that an initialization section will be executed only once
   * during a program's life time, and that concurrent threads are
   * blocked until initialization completed. To be used in constructs
   * like this:
   * |[<!-- language\="C" -->
   * static gsize initialization_value \= 0;
   * if $(LPAREN)g_once_init_enter $(LPAREN)&initialization_value$(RPAREN)$(RPAREN)
   * {
   * gsize setup_value \= 42; // initialization code here
   * g_once_init_leave $(LPAREN)&initialization_value, setup_value$(RPAREN);
   * }
   * // use initialization_value here
   * ]|
   * While location has a `volatile` qualifier, this is a historical artifact and
   * the pointer passed to it should not be `volatile`.
   * Params:
   *   location = location of a static initializable variable
   *     containing 0
   * Returns: %TRUE if the initialization section should be entered,
   *   %FALSE and blocks otherwise
   */
  static bool initEnter(ref void* location)
  {
    bool _retval;
    _retval = g_once_init_enter(cast(void*)&location);
    return _retval;
  }

  static bool initEnterImpl(out size_t location)
  {
    bool _retval;
    _retval = g_once_init_enter_impl(cast(size_t*)&location);
    return _retval;
  }

  /**
   * This functions behaves in the same way as [GLib.Once.initEnter], but can
   * can be used to initialize pointers $(LPAREN)or #guintptr$(RPAREN) instead of #gsize.
   * |[<!-- language\="C" -->
   * static MyStruct *interesting_struct \= NULL;
   * if $(LPAREN)g_once_init_enter_pointer $(LPAREN)&interesting_struct$(RPAREN)$(RPAREN)
   * {
   * MyStruct *setup_value \= allocate_my_struct $(LPAREN)$(RPAREN); // initialization code here
   * g_once_init_leave_pointer $(LPAREN)&interesting_struct, g_steal_pointer $(LPAREN)&setup_value$(RPAREN)$(RPAREN);
   * }
   * // use interesting_struct here
   * ]|
   * Params:
   *   location = location of a static initializable variable
   *     containing `NULL`
   * Returns: %TRUE if the initialization section should be entered,
   *   %FALSE and blocks otherwise
   */
  static bool initEnterPointer(void* location)
  {
    bool _retval;
    _retval = g_once_init_enter_pointer(location);
    return _retval;
  }

  /**
   * Counterpart to [GLib.Once.initEnter]. Expects a location of a static
   * 0-initialized initialization variable, and an initialization value
   * other than 0. Sets the variable to the initialization value, and
   * releases concurrent threads blocking in [GLib.Once.initEnter] on this
   * initialization variable.
   * While location has a `volatile` qualifier, this is a historical artifact and
   * the pointer passed to it should not be `volatile`.
   * Params:
   *   location = location of a static initializable variable
   *     containing 0
   *   result = new non-0 value for *value_location
   */
  static void initLeave(ref void* location, size_t result)
  {
    g_once_init_leave(cast(void*)&location, result);
  }

  /**
   * Counterpart to [GLib.Once.initEnterPointer]. Expects a location of a static
   * `NULL`-initialized initialization variable, and an initialization value
   * other than `NULL`. Sets the variable to the initialization value, and
   * releases concurrent threads blocking in [GLib.Once.initEnterPointer] on this
   * initialization variable.
   * This functions behaves in the same way as [GLib.Once.initLeave], but
   * can be used to initialize pointers $(LPAREN)or #guintptr$(RPAREN) instead of #gsize.
   * Params:
   *   location = location of a static initializable variable
   *     containing `NULL`
   *   result = new non-`NULL` value for `*location`
   */
  static void initLeavePointer(void* location, void* result)
  {
    g_once_init_leave_pointer(location, result);
  }
}
