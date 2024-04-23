module Gio.FileIcon;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.File;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GFileIcon specifies an icon by pointing to an image file
 * to be used as icon.
 */
class FileIcon : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_icon_get_type();
  }

  /**
   * a #GIcon for the given
   * @file, or %NULL on error.
   */
  this(File file)
  {
    GIcon* _cretval;
    _cretval = g_file_icon_new(file ? (cast(ObjectG)file).cPtr!GFile : null);
    this(_cretval, true);
  }

  /**
   * a #GFile.
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = g_file_icon_get_file(cPtr!GFileIcon);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, false);
    return _retval;
  }
}
