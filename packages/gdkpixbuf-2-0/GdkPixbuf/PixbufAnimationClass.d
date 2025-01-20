module GdkPixbuf.PixbufAnimationClass;

import GObject.ObjectClass;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * Modules supporting animations must derive a type from
 * #GdkPixbufAnimation, providing suitable implementations of the
 * virtual functions.
 */
class PixbufAnimationClass
{
  GdkPixbufAnimationClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GdkPixbuf.PixbufAnimationClass");

    cInstance = *cast(GdkPixbufAnimationClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GdkPixbufAnimationClass*)cPtr).parentClass);
  }

  alias IsStaticImageFuncType = extern(C) bool function(GdkPixbufAnimation* animation);

  @property IsStaticImageFuncType isStaticImage()
  {
    return (cast(GdkPixbufAnimationClass*)cPtr).isStaticImage;
  }

  alias GetStaticImageFuncType = extern(C) PixbufC* function(GdkPixbufAnimation* animation);

  @property GetStaticImageFuncType getStaticImage()
  {
    return (cast(GdkPixbufAnimationClass*)cPtr).getStaticImage;
  }

  alias GetSizeFuncType = extern(C) void function(GdkPixbufAnimation* animation, int* width, int* height);

  @property GetSizeFuncType getSize()
  {
    return (cast(GdkPixbufAnimationClass*)cPtr).getSize;
  }

  alias GetIterFuncType = extern(C) GdkPixbufAnimationIter* function(GdkPixbufAnimation* animation, const(GTimeVal)* startTime);

  @property GetIterFuncType getIter()
  {
    return (cast(GdkPixbufAnimationClass*)cPtr).getIter;
  }
}
