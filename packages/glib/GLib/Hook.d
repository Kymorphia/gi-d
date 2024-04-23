module GLib.Hook;

import GLib.HookList;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GHook))
  {
    return cast(T*)&cInstance;
  }

  @property Hook next()
  {
    return new Hook(cast(GHook*)cPtr!GHook.next);
  }

  @property Hook prev()
  {
    return new Hook(cast(GHook*)cPtr!GHook.prev);
  }

  @property uint refCount()
  {
    return cPtr!GHook.refCount;
  }

  @property void refCount(uint propval)
  {
    cPtr!GHook.refCount = propval;
  }

  @property ulong hookId()
  {
    return cPtr!GHook.hookId;
  }

  @property void hookId(ulong propval)
  {
    cPtr!GHook.hookId = propval;
  }

  @property uint flags()
  {
    return cPtr!GHook.flags;
  }

  @property void flags(uint propval)
  {
    cPtr!GHook.flags = propval;
  }

  @property GDestroyNotify destroy()
  {
    return cPtr!GHook.destroy;
  }

  @property void destroy(GDestroyNotify propval)
  {
    cPtr!GHook.destroy = propval;
  }

  /**
   * a value <= 0 if the id of @sibling is >= the id of @new_hook
   */
  int compareIds(Hook sibling)
  {
    int _retval;
    _retval = g_hook_compare_ids(cPtr!GHook, sibling ? sibling.cPtr!GHook : null);
    return _retval;
  }

  /**
   * %TRUE if the #GHook was found in the #GHookList and destroyed
   */
  static bool destroy(HookList hookList, ulong hookId)
  {
    bool _retval;
    _retval = g_hook_destroy(hookList ? hookList.cPtr!GHookList : null, hookId);
    return _retval;
  }

  /**
   * Removes one #GHook from a #GHookList, marking it
   * inactive and calling g_hook_unref() on it.
   */
  static void destroyLink(HookList hookList, Hook hook)
  {
    g_hook_destroy_link(hookList ? hookList.cPtr!GHookList : null, hook ? hook.cPtr!GHook : null);
  }

  /**
   * Calls the #GHookList @finalize_hook function if it exists,
   * and frees the memory allocated for the #GHook.
   */
  static void free(HookList hookList, Hook hook)
  {
    g_hook_free(hookList ? hookList.cPtr!GHookList : null, hook ? hook.cPtr!GHook : null);
  }

  /**
   * Inserts a #GHook into a #GHookList, before a given #GHook.
   */
  static void insertBefore(HookList hookList, Hook sibling, Hook hook)
  {
    g_hook_insert_before(hookList ? hookList.cPtr!GHookList : null, sibling ? sibling.cPtr!GHook : null, hook ? hook.cPtr!GHook : null);
  }

  /**
   * Prepends a #GHook on the start of a #GHookList.
   */
  static void prepend(HookList hookList, Hook hook)
  {
    g_hook_prepend(hookList ? hookList.cPtr!GHookList : null, hook ? hook.cPtr!GHook : null);
  }

  /**
   * Decrements the reference count of a #GHook.
   * If the reference count falls to 0, the #GHook is removed
   * from the #GHookList and g_hook_free() is called to free it.
   */
  static void unref(HookList hookList, Hook hook)
  {
    g_hook_unref(hookList ? hookList.cPtr!GHookList : null, hook ? hook.cPtr!GHook : null);
  }
}
