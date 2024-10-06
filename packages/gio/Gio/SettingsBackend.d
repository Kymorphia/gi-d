module Gio.SettingsBackend;

import GLib.Tree;
import GLib.Variant;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The `GSettingsBackend` interface defines a generic interface for
 * non-strictly-typed data that is stored in a hierarchy. To implement
 * an alternative storage backend for [Gio.Settings], you need to
 * implement the `GSettingsBackend` interface and then make it implement the
 * extension point `G_SETTINGS_BACKEND_EXTENSION_POINT_NAME`.
 * The interface defines methods for reading and writing values, a
 * method for determining if writing of certain values will fail
 * $(LPAREN)lockdown$(RPAREN) and a change notification mechanism.
 * The semantics of the interface are very precisely defined and
 * implementations must carefully adhere to the expectations of
 * callers that are documented on each of the interface methods.
 * Some of the `GSettingsBackend` functions accept or return a
 * [GLib.Tree]. These trees always have strings as keys and
 * [GLib.Variant] as values.
 * The `GSettingsBackend` API is exported to allow third-party
 * implementations, but does not carry the same stability guarantees
 * as the public GIO API. For this reason, you have to define the
 * C preprocessor symbol `G_SETTINGS_ENABLE_BACKEND` before including
 * `gio/gsettingsbackend.h`.
 */
class SettingsBackend : ObjectG
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
    return g_settings_backend_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Calculate the longest common prefix of all keys in a tree and write
   * out an array of the key names relative to that prefix and,
   * optionally, the value to store at each of those keys.
   * You must free the value returned in path, keys and values using
   * [GLib.Global.gfree].  You should not attempt to free or unref the contents of
   * keys or values.
   * Params:
   *   tree = a #GTree containing the changes
   *   path = the location to save the path
   *   keys = the
   *     location to save the relative keys
   *   values = the location to save the values, or %NULL
   */
  static void flattenTree(Tree tree, out string path, out string[] keys, out Variant[] values)
  {
    char* _path;
    const(char*)* _keys;
    GVariant** _values;
    g_settings_backend_flatten_tree(tree ? cast(GTree*)tree.cPtr(false) : null, &_path, &_keys, &_values);
    path = _path.fromCString(true);
    uint _lenkeys;
    if (_keys)
    {
      for (; _keys[_lenkeys] !is null; _lenkeys++)
      {
      }
    }
    keys.length = _lenkeys;
    foreach (i; 0 .. _lenkeys)
      keys[i] = _keys[i].fromCString(false);
    safeFree(cast(void*)_keys);
    uint _lenvalues;
    if (_values)
    {
      for (; _values[_lenvalues] !is null; _lenvalues++)
      {
      }
    }
    values.length = _lenvalues;
    foreach (i; 0 .. _lenvalues)
      values[i] = new Variant(cast(void*)_values[i], false);
    safeFree(cast(void*)_values);
  }

  /**
   * Returns the default #GSettingsBackend. It is possible to override
   * the default by setting the `GSETTINGS_BACKEND` environment variable
   * to the name of a settings backend.
   * The user gets a reference to the backend.
   * Returns: the default #GSettingsBackend,
   *   which will be a dummy $(LPAREN)memory$(RPAREN) settings backend if no other settings
   *   backend is available.
   */
  static SettingsBackend getDefault()
  {
    GSettingsBackend* _cretval;
    _cretval = g_settings_backend_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Signals that a single key has possibly changed.  Backend
   * implementations should call this if a key has possibly changed its
   * value.
   * key must be a valid key $(LPAREN)ie starting with a slash, not containing
   * '//', and not ending with a slash$(RPAREN).
   * The implementation must call this function during any call to
   * g_settings_backend_write$(LPAREN)$(RPAREN), before the call returns $(LPAREN)except in the
   * case that no keys are actually changed and it cares to detect this
   * fact$(RPAREN).  It may not rely on the existence of a mainloop for
   * dispatching the signal later.
   * The implementation may call this function at any other time it likes
   * in response to other events $(LPAREN)such as changes occurring outside of the
   * program$(RPAREN).  These calls may originate from a mainloop or may originate
   * in response to any other action $(LPAREN)including from calls to
   * g_settings_backend_write$(LPAREN)$(RPAREN)$(RPAREN).
   * In the case that this call is in response to a call to
   * g_settings_backend_write$(LPAREN)$(RPAREN) then origin_tag must be set to the same
   * value that was passed to that call.
   * Params:
   *   key = the name of the key
   *   originTag = the origin tag
   */
  void changed(string key, void* originTag)
  {
    const(char)* _key = key.toCString(false);
    g_settings_backend_changed(cast(GSettingsBackend*)cPtr, _key, originTag);
  }

  /**
   * This call is a convenience wrapper.  It gets the list of changes from
   * tree, computes the longest common prefix and calls
   * [Gio.SettingsBackend.changed].
   * Params:
   *   tree = a #GTree containing the changes
   *   originTag = the origin tag
   */
  void changedTree(Tree tree, void* originTag)
  {
    g_settings_backend_changed_tree(cast(GSettingsBackend*)cPtr, tree ? cast(GTree*)tree.cPtr(false) : null, originTag);
  }

  /**
   * Signals that a list of keys have possibly changed.  Backend
   * implementations should call this if keys have possibly changed their
   * values.
   * path must be a valid path $(LPAREN)ie starting and ending with a slash and
   * not containing '//'$(RPAREN).  Each string in items must form a valid key
   * name when path is prefixed to it $(LPAREN)ie: each item must not start or
   * end with '/' and must not contain '//'$(RPAREN).
   * The meaning of this signal is that any of the key names resulting
   * from the contatenation of path with each item in items may have
   * changed.
   * The same rules for when notifications must occur apply as per
   * [Gio.SettingsBackend.changed].  These two calls can be used
   * interchangeably if exactly one item has changed $(LPAREN)although in that
   * case [Gio.SettingsBackend.changed] is definitely preferred$(RPAREN).
   * For efficiency reasons, the implementation should strive for path to
   * be as long as possible $(LPAREN)ie: the longest common prefix of all of the
   * keys that were changed$(RPAREN) but this is not strictly required.
   * Params:
   *   path = the path containing the changes
   *   items = the %NULL-terminated list of changed keys
   *   originTag = the origin tag
   */
  void keysChanged(string path, string[] items, void* originTag)
  {
    const(char)* _path = path.toCString(false);
    char*[] _tmpitems;
    foreach (s; items)
      _tmpitems ~= s.toCString(false);
    _tmpitems ~= null;
    const(char*)* _items = _tmpitems.ptr;
    g_settings_backend_keys_changed(cast(GSettingsBackend*)cPtr, _path, _items, originTag);
  }

  /**
   * Signals that all keys below a given path may have possibly changed.
   * Backend implementations should call this if an entire path of keys
   * have possibly changed their values.
   * path must be a valid path $(LPAREN)ie starting and ending with a slash and
   * not containing '//'$(RPAREN).
   * The meaning of this signal is that any of the key which has a name
   * starting with path may have changed.
   * The same rules for when notifications must occur apply as per
   * [Gio.SettingsBackend.changed].  This call might be an appropriate
   * reasponse to a 'reset' call but implementations are also free to
   * explicitly list the keys that were affected by that call if they can
   * easily do so.
   * For efficiency reasons, the implementation should strive for path to
   * be as long as possible $(LPAREN)ie: the longest common prefix of all of the
   * keys that were changed$(RPAREN) but this is not strictly required.  As an
   * example, if this function is called with the path of "/" then every
   * single key in the application will be notified of a possible change.
   * Params:
   *   path = the path containing the changes
   *   originTag = the origin tag
   */
  void pathChanged(string path, void* originTag)
  {
    const(char)* _path = path.toCString(false);
    g_settings_backend_path_changed(cast(GSettingsBackend*)cPtr, _path, originTag);
  }

  /**
   * Signals that the writability of all keys below a given path may have
   * changed.
   * Since GSettings performs no locking operations for itself, this call
   * will always be made in response to external events.
   * Params:
   *   path = the name of the path
   */
  void pathWritableChanged(string path)
  {
    const(char)* _path = path.toCString(false);
    g_settings_backend_path_writable_changed(cast(GSettingsBackend*)cPtr, _path);
  }

  /**
   * Signals that the writability of a single key has possibly changed.
   * Since GSettings performs no locking operations for itself, this call
   * will always be made in response to external events.
   * Params:
   *   key = the name of the key
   */
  void writableChanged(string key)
  {
    const(char)* _key = key.toCString(false);
    g_settings_backend_writable_changed(cast(GSettingsBackend*)cPtr, _key);
  }
}
