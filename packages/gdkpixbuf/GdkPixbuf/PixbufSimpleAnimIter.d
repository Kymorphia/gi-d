module GdkPixbuf.PixbufSimpleAnimIter;

import GdkPixbuf.PixbufAnimationIter;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

class PixbufSimpleAnimIter : PixbufAnimationIter
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
    return gdk_pixbuf_simple_anim_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
