module GLib.Completion;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GCompletion` provides support for automatic completion of a string
 * using any group of target strings. It is typically used for file
 * name completion as is common in many UNIX shells.
 * A `GCompletion` is created using [GLib.Completion.new_]. Target items are
 * added and removed with [GLib.Completion.addItems],
 * [GLib.Completion.removeItems] and
 * [GLib.Completion.clearItems]. A completion attempt is requested with
 * [GLib.Completion.complete] or [GLib.Completion.completeUtf8].
 * When no longer needed, the `GCompletion` is freed with
 * [GLib.Completion.free].
 * Items in the completion can be simple strings $(LPAREN)e.g. filenames$(RPAREN), or
 * pointers to arbitrary data structures. If data structures are used
 * you must provide a [GLib.CompletionFunc] in [GLib.Completion.new_],
 * which retrieves the item’s string from the data structure. You can change
 * the way in which strings are compared by setting a different
 * [GLib.CompletionStrncmpFunc] in [GLib.Completion.setCompare].
 * `GCompletion` has been marked as deprecated, since this API is rarely
 * used and not very actively maintained.

 * Deprecated: Rarely used API
 */
class Completion
{
  GCompletion cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Completion");

    cInstance = *cast(GCompletion*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property GCompletionFunc func()
  {
    return (cast(GCompletion*)cPtr).func;
  }

  @property void func(GCompletionFunc propval)
  {
    (cast(GCompletion*)cPtr).func = propval;
  }

  @property string prefix()
  {
    return (cast(GCompletion*)cPtr).prefix.fromCString(false);
  }

  @property void prefix(string propval)
  {
    safeFree(cast(void*)(cast(GCompletion*)cPtr).prefix);
    (cast(GCompletion*)cPtr).prefix = propval.toCString(true);
  }

  @property GCompletionStrncmpFunc strncmpFunc()
  {
    return (cast(GCompletion*)cPtr).strncmpFunc;
  }

  @property void strncmpFunc(GCompletionStrncmpFunc propval)
  {
    (cast(GCompletion*)cPtr).strncmpFunc = propval;
  }

  /**
   * Removes all items from the #GCompletion. The items are not freed, so if the
   * memory was dynamically allocated, it should be freed after calling this
   * function.

   * Deprecated: Rarely used API
   */
  void clearItems()
  {
    g_completion_clear_items(cast(GCompletion*)cPtr);
  }

  /**
   * Attempts to complete the string prefix using the #GCompletion target items.
   * In contrast to [GLib.Completion.complete], this function returns the largest common
   * prefix that is a valid UTF-8 string, omitting a possible common partial
   * character.
   * You should use this function instead of [GLib.Completion.complete] if your
   * items are UTF-8 strings.
   * Params:
   *   prefix = the prefix string, typically used by the user, which is compared
   *     with each of the items
   *   newPrefix = if non-%NULL, returns the longest prefix which is common to all
   *     items that matched prefix, or %NULL if no items matched prefix.
   *     This string should be freed when no longer needed.
   * Returns: the list of items whose strings begin with prefix. This should
   *   not be changed.

   * Deprecated: Rarely used API
   */
  List!(string, char*) completeUtf8(string prefix, out string newPrefix)
  {
    GList* _cretval;
    const(char)* _prefix = prefix.toCString(false);
    char* _newPrefix;
    _cretval = g_completion_complete_utf8(cast(GCompletion*)cPtr, _prefix, &_newPrefix);
    List!(string, char*) _retval = new List!(string, char*)(cast(GList*)_cretval, GidOwnership.None);
    newPrefix = _newPrefix.fromCString(true);
    return _retval;
  }
}
