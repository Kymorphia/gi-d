module Gio.BytesIcon;

import GObject.ObjectG;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gio.LoadableIcon;
import Gio.LoadableIconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GBytesIcon` specifies an image held in memory in a common format $(LPAREN)usually
 * PNG$(RPAREN) to be used as icon.
 */
class BytesIcon : ObjectG, Icon, LoadableIcon
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
    return g_bytes_icon_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!();
  mixin LoadableIconT!();
}
