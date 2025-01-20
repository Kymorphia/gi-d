module Gdk.PaintableInterface;

import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The list of functions that can be implemented for the `GdkPaintable`
 * interface.
 * Note that apart from the vfunc@Gdk.Paintable.snapshot function,
 * no virtual function of this interface is mandatory to implement, though it
 * is a good idea to implement vfunc@Gdk.Paintable.get_current_image
 * for non-static paintables and vfunc@Gdk.Paintable.get_flags if the
 * image is not dynamic as the default implementation returns no flags and
 * that will make the implementation likely quite slow.
 */
class PaintableInterface
{
  GdkPaintableInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.PaintableInterface");

    cInstance = *cast(GdkPaintableInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias SnapshotFuncType = extern(C) void function(GdkPaintable* paintable, GdkSnapshot* snapshot, double width, double height);

  @property SnapshotFuncType snapshot()
  {
    return (cast(GdkPaintableInterface*)cPtr).snapshot;
  }

  alias GetCurrentImageFuncType = extern(C) GdkPaintable* function(GdkPaintable* paintable);

  @property GetCurrentImageFuncType getCurrentImage()
  {
    return (cast(GdkPaintableInterface*)cPtr).getCurrentImage;
  }

  alias GetFlagsFuncType = extern(C) GdkPaintableFlags function(GdkPaintable* paintable);

  @property GetFlagsFuncType getFlags()
  {
    return (cast(GdkPaintableInterface*)cPtr).getFlags;
  }

  alias GetIntrinsicWidthFuncType = extern(C) int function(GdkPaintable* paintable);

  @property GetIntrinsicWidthFuncType getIntrinsicWidth()
  {
    return (cast(GdkPaintableInterface*)cPtr).getIntrinsicWidth;
  }

  alias GetIntrinsicHeightFuncType = extern(C) int function(GdkPaintable* paintable);

  @property GetIntrinsicHeightFuncType getIntrinsicHeight()
  {
    return (cast(GdkPaintableInterface*)cPtr).getIntrinsicHeight;
  }

  alias GetIntrinsicAspectRatioFuncType = extern(C) double function(GdkPaintable* paintable);

  @property GetIntrinsicAspectRatioFuncType getIntrinsicAspectRatio()
  {
    return (cast(GdkPaintableInterface*)cPtr).getIntrinsicAspectRatio;
  }
}
