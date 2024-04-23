module Gio.Vfs;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.File;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Entry point for using GIO functionality.
 */
class Vfs : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_vfs_get_type();
  }

  /**
   * a #GVfs, which will be the local
   * file system #GVfs if no other implementation is available.
   */
  static Vfs getDefault()
  {
    GVfs* _cretval;
    _cretval = g_vfs_get_default();
    Vfs _retval = ObjectG.getDObject!Vfs(cast(GVfs*)_cretval, false);
    return _retval;
  }

  /**
   * a #GVfs.
   */
  static Vfs getLocal()
  {
    GVfs* _cretval;
    _cretval = g_vfs_get_local();
    Vfs _retval = ObjectG.getDObject!Vfs(cast(GVfs*)_cretval, false);
    return _retval;
  }

  /**
   * a #GFile.
   * Free the returned object with g_object_unref().
   */
  File getFileForPath(string path)
  {
    GFile* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_vfs_get_file_for_path(cPtr!GVfs, _path);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a #GFile.
   * Free the returned object with g_object_unref().
   */
  File getFileForUri(string uri)
  {
    GFile* _cretval;
    const(char)* _uri = uri.toCString(false);
    _cretval = g_vfs_get_file_for_uri(cPtr!GVfs, _uri);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a %NULL-terminated array of strings.
   * The returned array belongs to GIO and must
   * not be freed or modified.
   */
  string[] getSupportedUriSchemes()
  {
    const(char*)* _cretval;
    _cretval = g_vfs_get_supported_uri_schemes(cPtr!GVfs);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * %TRUE if construction of the @vfs was successful
   * and it is now active.
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_vfs_is_active(cPtr!GVfs);
    return _retval;
  }

  /**
   * a #GFile for the given @parse_name.
   * Free the returned object with g_object_unref().
   */
  File parseName(string parseName)
  {
    GFile* _cretval;
    const(char)* _parseName = parseName.toCString(false);
    _cretval = g_vfs_parse_name(cPtr!GVfs, _parseName);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @scheme was successfully unregistered, or %FALSE if a
   * handler for @scheme does not exist.
   */
  bool unregisterUriScheme(string scheme)
  {
    bool _retval;
    const(char)* _scheme = scheme.toCString(false);
    _retval = g_vfs_unregister_uri_scheme(cPtr!GVfs, _scheme);
    return _retval;
  }
}
