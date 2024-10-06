module GdkPixbuf.PixbufAnimationIterClass;

import GObject.ObjectClass;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * Modules supporting animations must derive a type from
 * #GdkPixbufAnimationIter, providing suitable implementations of the
 * virtual functions.
 */
class PixbufAnimationIterClass
{
  GdkPixbufAnimationIterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GdkPixbuf.PixbufAnimationIterClass");

    cInstance = *cast(GdkPixbufAnimationIterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GdkPixbufAnimationIterClass*)cPtr).parentClass);
  }

  alias GetDelayTimeFuncType = extern(C) int function(GdkPixbufAnimationIter* iter);

  @property GetDelayTimeFuncType getDelayTime()
  {
    return (cast(GdkPixbufAnimationIterClass*)cPtr).getDelayTime;
  }

  alias GetPixbufFuncType = extern(C) PixbufC* function(GdkPixbufAnimationIter* iter);

  @property GetPixbufFuncType getPixbuf()
  {
    return (cast(GdkPixbufAnimationIterClass*)cPtr).getPixbuf;
  }

  alias OnCurrentlyLoadingFrameFuncType = extern(C) bool function(GdkPixbufAnimationIter* iter);

  @property OnCurrentlyLoadingFrameFuncType onCurrentlyLoadingFrame()
  {
    return (cast(GdkPixbufAnimationIterClass*)cPtr).onCurrentlyLoadingFrame;
  }

  alias AdvanceFuncType = extern(C) bool function(GdkPixbufAnimationIter* iter, const(GTimeVal)* currentTime);

  @property AdvanceFuncType advance()
  {
    return (cast(GdkPixbufAnimationIterClass*)cPtr).advance;
  }
}
