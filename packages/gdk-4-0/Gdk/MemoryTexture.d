module Gdk.MemoryTexture;

import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gio.LoadableIcon;
import Gio.LoadableIconT;

/**
 * A `GdkTexture` representing image data in memory.
 */
class MemoryTexture : Texture
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
    return gdk_memory_texture_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
