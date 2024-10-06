module Gtk.SymbolicPaintableInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The list of virtual functions for the `GtkSymbolicPaintable` interface.
 * No function must be implemented, default implementations exist for each one.
 */
class SymbolicPaintableInterface
{
  GtkSymbolicPaintableInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.SymbolicPaintableInterface");

    cInstance = *cast(GtkSymbolicPaintableInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias SnapshotSymbolicFuncType = extern(C) void function(GtkSymbolicPaintable* paintable, GdkSnapshot* snapshot, double width, double height, const(GdkRGBA)* colors, size_t nColors);

  @property SnapshotSymbolicFuncType snapshotSymbolic()
  {
    return (cast(GtkSymbolicPaintableInterface*)cPtr).snapshotSymbolic;
  }
}
