module GLib.HookList;

import GLib.Hook;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GHookList struct represents a list of hook functions.
 */
class HookList
{
  GHookList cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.HookList");

    cInstance = *cast(GHookList*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ulong seqId()
  {
    return (cast(GHookList*)cPtr).seqId;
  }

  @property void seqId(ulong propval)
  {
    (cast(GHookList*)cPtr).seqId = propval;
  }

  @property uint hookSize()
  {
    return (cast(GHookList*)cPtr).hookSize;
  }

  @property void hookSize(uint propval)
  {
    (cast(GHookList*)cPtr).hookSize = propval;
  }

  @property uint isSetup()
  {
    return (cast(GHookList*)cPtr).isSetup;
  }

  @property void isSetup(uint propval)
  {
    (cast(GHookList*)cPtr).isSetup = propval;
  }

  @property Hook hooks()
  {
    return new Hook(cast(GHook*)(cast(GHookList*)cPtr).hooks);
  }

  @property GHookFinalizeFunc finalizeHook()
  {
    return (cast(GHookList*)cPtr).finalizeHook;
  }

  @property void finalizeHook(GHookFinalizeFunc propval)
  {
    (cast(GHookList*)cPtr).finalizeHook = propval;
  }

  /**
   * Removes all the #GHook elements from a #GHookList.
   */
  void clear()
  {
    g_hook_list_clear(cast(GHookList*)cPtr);
  }

  /**
   * Initializes a #GHookList.
   * This must be called before the #GHookList is used.
   * Params:
   *   hookSize = the size of each element in the #GHookList,
   *     typically `sizeof $(LPAREN)GHook$(RPAREN)`.
   */
  void init_(uint hookSize)
  {
    g_hook_list_init(cast(GHookList*)cPtr, hookSize);
  }

  /**
   * Calls all of the #GHook functions in a #GHookList.
   * Params:
   *   mayRecurse = %TRUE if functions which are already running
   *     $(LPAREN)e.g. in another thread$(RPAREN) can be called. If set to %FALSE,
   *     these are skipped
   */
  void invoke(bool mayRecurse)
  {
    g_hook_list_invoke(cast(GHookList*)cPtr, mayRecurse);
  }

  /**
   * Calls all of the #GHook functions in a #GHookList.
   * Any function which returns %FALSE is removed from the #GHookList.
   * Params:
   *   mayRecurse = %TRUE if functions which are already running
   *     $(LPAREN)e.g. in another thread$(RPAREN) can be called. If set to %FALSE,
   *     these are skipped
   */
  void invokeCheck(bool mayRecurse)
  {
    g_hook_list_invoke_check(cast(GHookList*)cPtr, mayRecurse);
  }

  /**
   * Calls a function on each valid #GHook.
   * Params:
   *   mayRecurse = %TRUE if hooks which are currently running
   *     $(LPAREN)e.g. in another thread$(RPAREN) are considered valid. If set to %FALSE,
   *     these are skipped
   *   marshaller = the function to call for each #GHook
   */
  void marshal(bool mayRecurse, HookMarshaller marshaller)
  {
    static HookMarshaller _static_marshaller;

    extern(C) void _marshallerCallback(GHook* hook, void* marshalData)
    {
      _static_marshaller(hook ? new Hook(cast(void*)hook, false) : null);
    }

    _static_marshaller = marshaller;
    auto _marshaller = freezeDelegate(cast(void*)&marshaller);
    g_hook_list_marshal(cast(GHookList*)cPtr, mayRecurse, &_marshallerCallback, _marshaller);
    _static_marshaller = null;
  }

  /**
   * Calls a function on each valid #GHook and destroys it if the
   * function returns %FALSE.
   * Params:
   *   mayRecurse = %TRUE if hooks which are currently running
   *     $(LPAREN)e.g. in another thread$(RPAREN) are considered valid. If set to %FALSE,
   *     these are skipped
   *   marshaller = the function to call for each #GHook
   */
  void marshalCheck(bool mayRecurse, HookCheckMarshaller marshaller)
  {
    static HookCheckMarshaller _static_marshaller;

    extern(C) bool _marshallerCallback(GHook* hook, void* marshalData)
    {
      bool _retval = _static_marshaller(hook ? new Hook(cast(void*)hook, false) : null);
      return _retval;
    }

    _static_marshaller = marshaller;
    auto _marshaller = freezeDelegate(cast(void*)&marshaller);
    g_hook_list_marshal_check(cast(GHookList*)cPtr, mayRecurse, &_marshallerCallback, _marshaller);
    _static_marshaller = null;
  }
}
