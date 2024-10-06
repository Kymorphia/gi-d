module Gio.FileIcon;

import GObject.ObjectG;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gio.Icon;
import Gio.IconT;
import Gio.LoadableIcon;
import Gio.LoadableIconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GFileIcon` specifies an icon by pointing to an image file
 * to be used as icon.
 * It implements [Gio.LoadableIcon].
 */
class FileIcon : ObjectG, Icon, LoadableIcon
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
    return g_file_icon_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!GFileIcon;
  mixin LoadableIconT!GFileIcon;

  /**
   * Creates a new icon for a file.
   * Params:
   *   file = a #GFile.
   * Returns: a #GIcon for the given
   *   file, or %NULL on error.
   */
  this(File file)
  {
    GIcon* _cretval;
    _cretval = g_file_icon_new(file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets the #GFile associated with the given icon.
   * Returns: a #GFile.
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = g_file_icon_get_file(cast(GFileIcon*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }
}
