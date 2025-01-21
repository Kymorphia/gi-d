module GLib.Cache;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GCache` allows sharing of complex data structures, in order to
 * save system resources.
 * `GCache` uses keys and values. A `GCache` key describes the properties
 * of a particular resource. A `GCache` value is the actual resource.
 * `GCache` has been marked as deprecated, since this API is rarely
 * used and not very actively maintained.

 * Deprecated: Use a #GHashTable instead
 */
class Cache
{
  GCache* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Cache");

    cInstancePtr = cast(GCache*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Frees the memory allocated for the #GCache.
   * Note that it does not destroy the keys and values which were
   * contained in the #GCache.

   * Deprecated: Use a #GHashTable instead
   */
  void destroy()
  {
    g_cache_destroy(cast(GCache*)cPtr);
  }

  /**
   * Gets the value corresponding to the given key, creating it if
   * necessary. It first checks if the value already exists in the
   * #GCache, by using the key_equal_func function passed to
   * [GLib.Cache.new_]. If it does already exist it is returned, and its
   * reference count is increased by one. If the value does not currently
   * exist, if is created by calling the value_new_func. The key is
   * duplicated by calling key_dup_func and the duplicated key and value
   * are inserted into the #GCache.
   * Params:
   *   key = a key describing a #GCache object
   * Returns: a pointer to a #GCache value

   * Deprecated: Use a #GHashTable instead
   */
  void* insert(void* key)
  {
    void* _retval;
    _retval = g_cache_insert(cast(GCache*)cPtr, key);
    return _retval;
  }

  /**
   * Calls the given function for each of the keys in the #GCache.
   * NOTE func is passed three parameters, the value and key of a cache
   * entry and the user_data. The order of value and key is different
   * from the order in which [GLib.HashTable.foreach_] passes key-value
   * pairs to its callback function !
   * Params:
   *   func = the function to call with each #GCache key

   * Deprecated: Use a #GHashTable instead
   */
  void keyForeach(HFunc func)
  {
    extern(C) void _funcCallback(void* key, void* value, void* userData)
    {
      auto _dlg = cast(HFunc*)userData;

      (*_dlg)(key, value);
    }

    auto _func = cast(void*)&func;
    g_cache_key_foreach(cast(GCache*)cPtr, &_funcCallback, _func);
  }

  /**
   * Decreases the reference count of the given value. If it drops to 0
   * then the value and its corresponding key are destroyed, using the
   * value_destroy_func and key_destroy_func passed to [GLib.Cache.new_].
   * Params:
   *   value = the value to remove

   * Deprecated: Use a #GHashTable instead
   */
  void remove(const(void)* value)
  {
    g_cache_remove(cast(GCache*)cPtr, value);
  }

  /**
   * Calls the given function for each of the values in the #GCache.
   * Params:
   *   func = the function to call with each #GCache value

   * Deprecated: The reason is that it passes pointers to internal
   *   data structures to func; use [GLib.Cache.keyForeach] instead
   */
  void valueForeach(HFunc func)
  {
    extern(C) void _funcCallback(void* key, void* value, void* userData)
    {
      auto _dlg = cast(HFunc*)userData;

      (*_dlg)(key, value);
    }

    auto _func = cast(void*)&func;
    g_cache_value_foreach(cast(GCache*)cPtr, &_funcCallback, _func);
  }
}
