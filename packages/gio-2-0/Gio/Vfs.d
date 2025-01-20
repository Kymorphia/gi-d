module Gio.Vfs;

import GObject.ObjectG;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Entry point for using GIO functionality.
 */
class Vfs : ObjectG
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
    return g_vfs_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the default #GVfs for the system.
   * Returns: a #GVfs, which will be the local
   *   file system #GVfs if no other implementation is available.
   */
  static Vfs getDefault()
  {
    GVfs* _cretval;
    _cretval = g_vfs_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!Vfs(cast(GVfs*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the local #GVfs for the system.
   * Returns: a #GVfs.
   */
  static Vfs getLocal()
  {
    GVfs* _cretval;
    _cretval = g_vfs_get_local();
    auto _retval = _cretval ? ObjectG.getDObject!Vfs(cast(GVfs*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets a #GFile for path.
   * Params:
   *   path = a string containing a VFS path.
   * Returns: a #GFile.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  File getFileForPath(string path)
  {
    GFile* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_vfs_get_file_for_path(cast(GVfs*)cPtr, _path);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a #GFile for uri.
   * This operation never fails, but the returned object
   * might not support any I/O operation if the URI
   * is malformed or if the URI scheme is not supported.
   * Params:
   *   uri = a string containing a URI
   * Returns: a #GFile.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  File getFileForUri(string uri)
  {
    GFile* _cretval;
    const(char)* _uri = uri.toCString(false);
    _cretval = g_vfs_get_file_for_uri(cast(GVfs*)cPtr, _uri);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of URI schemes supported by vfs.
   * Returns: a %NULL-terminated array of strings.
   *   The returned array belongs to GIO and must
   *   not be freed or modified.
   */
  string[] getSupportedUriSchemes()
  {
    const(char*)* _cretval;
    _cretval = g_vfs_get_supported_uri_schemes(cast(GVfs*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Checks if the VFS is active.
   * Returns: %TRUE if construction of the vfs was successful
   *   and it is now active.
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_vfs_is_active(cast(GVfs*)cPtr);
    return _retval;
  }

  /**
   * This operation never fails, but the returned object might
   * not support any I/O operations if the parse_name cannot
   * be parsed by the #GVfs module.
   * Params:
   *   parseName = a string to be parsed by the VFS module.
   * Returns: a #GFile for the given parse_name.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  File parseName(string parseName)
  {
    GFile* _cretval;
    const(char)* _parseName = parseName.toCString(false);
    _cretval = g_vfs_parse_name(cast(GVfs*)cPtr, _parseName);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Unregisters the URI handler for scheme previously registered with
   * [Gio.Vfs.registerUriScheme].
   * Params:
   *   scheme = an URI scheme, e.g. "http"
   * Returns: %TRUE if scheme was successfully unregistered, or %FALSE if a
   *   handler for scheme does not exist.
   */
  bool unregisterUriScheme(string scheme)
  {
    bool _retval;
    const(char)* _scheme = scheme.toCString(false);
    _retval = g_vfs_unregister_uri_scheme(cast(GVfs*)cPtr, _scheme);
    return _retval;
  }
}
