module GdkPixbuf.PixbufNonAnim;

import GdkPixbuf.Pixbuf;
import GdkPixbuf.PixbufAnimation;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

class PixbufNonAnim : PixbufAnimation
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
    return gdk_pixbuf_non_anim_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this(Pixbuf pixbuf)
  {
    GdkPixbufAnimation* _cretval;
    _cretval = gdk_pixbuf_non_anim_new(pixbuf ? cast(PixbufC*)pixbuf.cPtr(false) : null);
    this(_cretval, true);
  }
}
