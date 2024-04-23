module GLib.HookList;

import GLib.Hook;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GHookList))
  {
    return cast(T*)&cInstance;
  }

  @property ulong seqId()
  {
    return cPtr!GHookList.seqId;
  }

  @property void seqId(ulong propval)
  {
    cPtr!GHookList.seqId = propval;
  }

  @property uint hookSize()
  {
    return cPtr!GHookList.hookSize;
  }

  @property void hookSize(uint propval)
  {
    cPtr!GHookList.hookSize = propval;
  }

  @property uint isSetup()
  {
    return cPtr!GHookList.isSetup;
  }

  @property void isSetup(uint propval)
  {
    cPtr!GHookList.isSetup = propval;
  }

  @property Hook hooks()
  {
    return new Hook(cast(GHook*)cPtr!GHookList.hooks);
  }

  @property GHookFinalizeFunc finalizeHook()
  {
    return cPtr!GHookList.finalizeHook;
  }

  @property void finalizeHook(GHookFinalizeFunc propval)
  {
    cPtr!GHookList.finalizeHook = propval;
  }

  /**
   * Removes all the #GHook elements from a #GHookList.
   */
  void clear()
  {
    g_hook_list_clear(cPtr!GHookList);
  }

  /**
   * Initializes a #GHookList.
   * This must be called before the #GHookList is used.
   */
  void init_(uint hookSize)
  {
    g_hook_list_init(cPtr!GHookList, hookSize);
  }

  /**
   * Calls all of the #GHook functions in a #GHookList.
   */
  void invoke(bool mayRecurse)
  {
    g_hook_list_invoke(cPtr!GHookList, mayRecurse);
  }

  /**
   * Calls all of the #GHook functions in a #GHookList.
   * Any function which returns %FALSE is removed from the #GHookList.
   */
  void invokeCheck(bool mayRecurse)
  {
    g_hook_list_invoke_check(cPtr!GHookList, mayRecurse);
  }
}
