module cairo.Path;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A data structure for holding a path. This data structure serves as
 * the return value for [cairo.Context.copyPath] and
 * [cairo.Context.copyPathFlat] as well the input value for
 * [cairo.Context.appendPath].
 * See #cairo_path_data_t for hints on how to iterate over the
 * actual data within the path.
 * The num_data member gives the number of elements in the data
 * array. This number is larger than the number of independent path
 * portions $(LPAREN)defined in #cairo_path_data_type_t$(RPAREN), since the data
 * includes both headers and coordinates for each portion.
 */
class Path : Boxed
{

  this()
  {
    super(safeMalloc(cairo_path_t.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return cairo_gobject_path_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Status status()
  {
    return cast(Status)(cast(cairo_path_t*)cPtr).status;
  }

  @property void status(Status propval)
  {
    (cast(cairo_path_t*)cPtr).status = cast(cairo_status_t)propval;
  }

  @property int numData()
  {
    return (cast(cairo_path_t*)cPtr).numData;
  }

  @property void numData(int propval)
  {
    (cast(cairo_path_t*)cPtr).numData = propval;
  }
}
