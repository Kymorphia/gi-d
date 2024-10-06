module Gio.UnixMountPoint;

import GLib.Boxed;
import GObject.ObjectG;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Defines a Unix mount point $(LPAREN)e.g. <filename>/dev</filename>$(RPAREN).
 * This corresponds roughly to a fstab entry.
 */
class UnixMountPoint : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_unix_mount_point_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Compares two unix mount points.
   * Params:
   *   mount2 = a #GUnixMount.
   * Returns: 1, 0 or -1 if mount1 is greater than, equal to,
   *   or less than mount2, respectively.
   */
  int compare(UnixMountPoint mount2)
  {
    int _retval;
    _retval = g_unix_mount_point_compare(cast(GUnixMountPoint*)cPtr, mount2 ? cast(GUnixMountPoint*)mount2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Makes a copy of mount_point.
   * Returns: a new #GUnixMountPoint
   */
  UnixMountPoint copy()
  {
    GUnixMountPoint* _cretval;
    _cretval = g_unix_mount_point_copy(cast(GUnixMountPoint*)cPtr);
    auto _retval = _cretval ? new UnixMountPoint(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the device path for a unix mount point.
   * Returns: a string containing the device path.
   */
  string getDevicePath()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_device_path(cast(GUnixMountPoint*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the file system type for the mount point.
   * Returns: a string containing the file system type.
   */
  string getFsType()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_fs_type(cast(GUnixMountPoint*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the mount path for a unix mount point.
   * Returns: a string containing the mount path.
   */
  string getMountPath()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_mount_path(cast(GUnixMountPoint*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the options for the mount point.
   * Returns: a string containing the options.
   */
  string getOptions()
  {
    const(char)* _cretval;
    _cretval = g_unix_mount_point_get_options(cast(GUnixMountPoint*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Guesses whether a Unix mount point can be ejected.
   * Returns: %TRUE if mount_point is deemed to be ejectable.
   */
  bool guessCanEject()
  {
    bool _retval;
    _retval = g_unix_mount_point_guess_can_eject(cast(GUnixMountPoint*)cPtr);
    return _retval;
  }

  /**
   * Guesses the icon of a Unix mount point.
   * Returns: a #GIcon
   */
  Icon guessIcon()
  {
    GIcon* _cretval;
    _cretval = g_unix_mount_point_guess_icon(cast(GUnixMountPoint*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Guesses the name of a Unix mount point.
   * The result is a translated string.
   * Returns: A newly allocated string that must
   *   be freed with [GLib.Global.gfree]
   */
  string guessName()
  {
    char* _cretval;
    _cretval = g_unix_mount_point_guess_name(cast(GUnixMountPoint*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Guesses the symbolic icon of a Unix mount point.
   * Returns: a #GIcon
   */
  Icon guessSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_unix_mount_point_guess_symbolic_icon(cast(GUnixMountPoint*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if a unix mount point is a loopback device.
   * Returns: %TRUE if the mount point is a loopback. %FALSE otherwise.
   */
  bool isLoopback()
  {
    bool _retval;
    _retval = g_unix_mount_point_is_loopback(cast(GUnixMountPoint*)cPtr);
    return _retval;
  }

  /**
   * Checks if a unix mount point is read only.
   * Returns: %TRUE if a mount point is read only.
   */
  bool isReadonly()
  {
    bool _retval;
    _retval = g_unix_mount_point_is_readonly(cast(GUnixMountPoint*)cPtr);
    return _retval;
  }

  /**
   * Checks if a unix mount point is mountable by the user.
   * Returns: %TRUE if the mount point is user mountable.
   */
  bool isUserMountable()
  {
    bool _retval;
    _retval = g_unix_mount_point_is_user_mountable(cast(GUnixMountPoint*)cPtr);
    return _retval;
  }

  /**
   * Gets a #GUnixMountPoint for a given mount path. If time_read is set, it
   * will be filled with a unix timestamp for checking if the mount points have
   * changed since with [Gio.DGioGlobal.unixMountPointsChangedSince].
   * If more mount points have the same mount path, the last matching mount point
   * is returned.
   * Params:
   *   mountPath = path for a possible unix mount point.
   *   timeRead = guint64 to contain a timestamp.
   * Returns: a #GUnixMountPoint, or %NULL if no match
   *   is found.
   */
  static UnixMountPoint at(string mountPath, out ulong timeRead)
  {
    GUnixMountPoint* _cretval;
    const(char)* _mountPath = mountPath.toCString(false);
    _cretval = g_unix_mount_point_at(_mountPath, cast(ulong*)&timeRead);
    auto _retval = _cretval ? new UnixMountPoint(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
