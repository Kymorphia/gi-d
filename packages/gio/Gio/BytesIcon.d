module Gio.BytesIcon;

import GLib.Bytes;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GBytesIcon specifies an image held in memory in a common format (usually
 * png) to be used as icon.
 */
class BytesIcon : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_bytes_icon_get_type();
  }

  /**
   * a #GIcon for the given
   * @bytes.
   */
  this(Bytes bytes)
  {
    GIcon* _cretval;
    _cretval = g_bytes_icon_new(bytes ? bytes.cPtr!GBytes : null);
    this(_cretval, true);
  }

  /**
   * a #GBytes.
   */
  Bytes getBytes()
  {
    GBytes* _cretval;
    _cretval = g_bytes_icon_get_bytes(cPtr!GBytesIcon);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, false);
    return _retval;
  }
}
