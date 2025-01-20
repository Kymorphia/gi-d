module GLib.Hook;

import GLib.HookList;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GHook struct represents a single hook function in a #GHookList.
 */
class Hook
{
  GHook cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Hook");

    cInstance = *cast(GHook*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Hook next()
  {
    return new Hook(cast(GHook*)(cast(GHook*)cPtr).next);
  }

  @property Hook prev()
  {
    return new Hook(cast(GHook*)(cast(GHook*)cPtr).prev);
  }

  @property uint refCount()
  {
    return (cast(GHook*)cPtr).refCount;
  }

  @property void refCount(uint propval)
  {
    (cast(GHook*)cPtr).refCount = propval;
  }

  @property ulong hookId()
  {
    return (cast(GHook*)cPtr).hookId;
  }

  @property void hookId(ulong propval)
  {
    (cast(GHook*)cPtr).hookId = propval;
  }

  @property uint flags()
  {
    return (cast(GHook*)cPtr).flags;
  }

  @property void flags(uint propval)
  {
    (cast(GHook*)cPtr).flags = propval;
  }

  @property GDestroyNotify destroy()
  {
    return (cast(GHook*)cPtr).destroy;
  }

  @property void destroy(GDestroyNotify propval)
  {
    (cast(GHook*)cPtr).destroy = propval;
  }

  /**
   * Compares the ids of two #GHook elements, returning a negative value
   * if the second id is greater than the first.
   * Params:
   *   sibling = a #GHook to compare with new_hook
   * Returns: a value <\= 0 if the id of sibling is >\= the id of new_hook
   */
  int compareIds(Hook sibling)
  {
    int _retval;
    _retval = g_hook_compare_ids(cast(GHook*)cPtr, sibling ? cast(GHook*)sibling.cPtr : null);
    return _retval;
  }

  /**
   * Destroys a #GHook, given its ID.
   * Params:
   *   hookList = a #GHookList
   *   hookId = a hook ID
   * Returns: %TRUE if the #GHook was found in the #GHookList and destroyed
   */
  static bool destroy(HookList hookList, ulong hookId)
  {
    bool _retval;
    _retval = g_hook_destroy(hookList ? cast(GHookList*)hookList.cPtr : null, hookId);
    return _retval;
  }

  /**
   * Removes one #GHook from a #GHookList, marking it
   * inactive and calling [GLib.Hook.unref] on it.
   * Params:
   *   hookList = a #GHookList
   *   hook = the #GHook to remove
   */
  static void destroyLink(HookList hookList, Hook hook)
  {
    g_hook_destroy_link(hookList ? cast(GHookList*)hookList.cPtr : null, hook ? cast(GHook*)hook.cPtr : null);
  }

  /**
   * Calls the #GHookList finalize_hook function if it exists,
   * and frees the memory allocated for the #GHook.
   * Params:
   *   hookList = a #GHookList
   *   hook = the #GHook to free
   */
  static void free(HookList hookList, Hook hook)
  {
    g_hook_free(hookList ? cast(GHookList*)hookList.cPtr : null, hook ? cast(GHook*)hook.cPtr : null);
  }

  /**
   * Inserts a #GHook into a #GHookList, before a given #GHook.
   * Params:
   *   hookList = a #GHookList
   *   sibling = the #GHook to insert the new #GHook before
   *   hook = the #GHook to insert
   */
  static void insertBefore(HookList hookList, Hook sibling, Hook hook)
  {
    g_hook_insert_before(hookList ? cast(GHookList*)hookList.cPtr : null, sibling ? cast(GHook*)sibling.cPtr : null, hook ? cast(GHook*)hook.cPtr : null);
  }

  /**
   * Inserts a #GHook into a #GHookList, sorted by the given function.
   * Params:
   *   hookList = a #GHookList
   *   hook = the #GHook to insert
   *   func = the comparison function used to sort the #GHook elements
   */
  static void insertSorted(HookList hookList, Hook hook, HookCompareFunc func)
  {
    static HookCompareFunc _static_func;

    extern(C) int _funcCallback(GHook* newHook, GHook* sibling)
    {
      int _retval = _static_func(newHook ? new Hook(cast(void*)newHook, false) : null, sibling ? new Hook(cast(void*)sibling, false) : null);
      return _retval;
    }

    _static_func = func;
    g_hook_insert_sorted(hookList ? cast(GHookList*)hookList.cPtr : null, hook ? cast(GHook*)hook.cPtr : null, &_funcCallback);
    _static_func = null;
  }

  /**
   * Prepends a #GHook on the start of a #GHookList.
   * Params:
   *   hookList = a #GHookList
   *   hook = the #GHook to add to the start of hook_list
   */
  static void prepend(HookList hookList, Hook hook)
  {
    g_hook_prepend(hookList ? cast(GHookList*)hookList.cPtr : null, hook ? cast(GHook*)hook.cPtr : null);
  }

  /**
   * Decrements the reference count of a #GHook.
   * If the reference count falls to 0, the #GHook is removed
   * from the #GHookList and [GLib.Hook.free] is called to free it.
   * Params:
   *   hookList = a #GHookList
   *   hook = the #GHook to unref
   */
  static void unref(HookList hookList, Hook hook)
  {
    g_hook_unref(hookList ? cast(GHookList*)hookList.cPtr : null, hook ? cast(GHook*)hook.cPtr : null);
  }
}
