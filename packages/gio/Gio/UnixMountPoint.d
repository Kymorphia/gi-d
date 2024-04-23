module Gio.UnixMountPoint;

import GLib.Boxed;
import GLib.Types;
import GObject.ObjectG;
import Gid.Gid;
import Gio.Icon;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Defines a Unix mount point (e.g. <filename>/dev</filename>).
 * This corresponds roughly to a fstab entry.
 */
class UnixMountPoint : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GUnixMountPoint))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_unix_mount_point_get_type();
  }

  /**
   * 1, 0 or -1 if @mount1 is greater than, equal to,
   * or less than @mount2, respectively.
   */
  int compare(UnixMountPoint mount2)
  {
    int _retval;
    _retval = g_unix_mount_point_compare(cPtr!GUnixMountPoint, mount2 ? mount2.cPtr!GUnixMountPoint : null);
    return _retval;
  }

  /**
   * a new #GUnixMountPoint
   */
  UnixMountPoint copy()
  {
    GUnixMountPoint* _cretval;
    _cretval = g_unix_mount_point_copy(cPtr!GUnixMountPoint);
    UnixMountPoint _retval = new UnixMountPoint(cast(GUnixMountPoint*)_cretval, true);
    return _retval;
  }

  /**
   * a string containing the device path.
   */
  string getDevicePath()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_device_path(cPtr!GUnixMountPoint);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing the file system type.
   */
  string getFsType()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_fs_type(cPtr!GUnixMountPoint);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing the mount path.
   */
  string getMountPath()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_mount_path(cPtr!GUnixMountPoint);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing the options.
   */
  string getOptions()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_options(cPtr!GUnixMountPoint);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if @mount_point is deemed to be ejectable.
   */
  bool guessCanEject()
  {
    bool _retval;
    _retval = g_unix_mount_point_guess_can_eject(cPtr!GUnixMountPoint);
    return _retval;
  }

  /**
   * a #GIcon
   */
  Icon guessIcon()
  {
    GIcon* _cretval;
    _cretval = g_unix_mount_point_guess_icon(cPtr!GUnixMountPoint);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * A newly allocated string that must
   * be freed with g_free()
   */
  string guessName()
  {
    char* _cretval;
    _cretval = g_unix_mount_point_guess_name(cPtr!GUnixMountPoint);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a #GIcon
   */
  Icon guessSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_unix_mount_point_guess_symbolic_icon(cPtr!GUnixMountPoint);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the mount point is a loopback. %FALSE otherwise.
   */
  bool isLoopback()
  {
    bool _retval;
    _retval = g_unix_mount_point_is_loopback(cPtr!GUnixMountPoint);
    return _retval;
  }

  /**
   * %TRUE if a mount point is read only.
   */
  bool isReadonly()
  {
    bool _retval;
    _retval = g_unix_mount_point_is_readonly(cPtr!GUnixMountPoint);
    return _retval;
  }

  /**
   * %TRUE if the mount point is user mountable.
   */
  bool isUserMountable()
  {
    bool _retval;
    _retval = g_unix_mount_point_is_user_mountable(cPtr!GUnixMountPoint);
    return _retval;
  }

  /**
   * a #GUnixMountPoint, or %NULL if no match
   * is found.
   */
  static UnixMountPoint at(string mountPath, out ulong timeRead)
  {
    GUnixMountPoint* _cretval;
    const(char)* _mountPath = mountPath.toCString(false);
    _cretval = g_unix_mount_point_at(_mountPath, cast(ulong*)&timeRead);
    UnixMountPoint _retval = new UnixMountPoint(cast(GUnixMountPoint*)_cretval, true);
    return _retval;
  }
}
