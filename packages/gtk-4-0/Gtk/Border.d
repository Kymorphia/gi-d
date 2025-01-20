module Gtk.Border;

import GLib.Boxed;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A struct that specifies a border around a rectangular area.
 * Each side can have different width.
 */
class Border : Boxed
{

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
    return gtk_border_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property short left()
  {
    return (cast(GtkBorder*)cPtr).left;
  }

  @property void left(short propval)
  {
    (cast(GtkBorder*)cPtr).left = propval;
  }

  @property short right()
  {
    return (cast(GtkBorder*)cPtr).right;
  }

  @property void right(short propval)
  {
    (cast(GtkBorder*)cPtr).right = propval;
  }

  @property short top()
  {
    return (cast(GtkBorder*)cPtr).top;
  }

  @property void top(short propval)
  {
    (cast(GtkBorder*)cPtr).top = propval;
  }

  @property short bottom()
  {
    return (cast(GtkBorder*)cPtr).bottom;
  }

  @property void bottom(short propval)
  {
    (cast(GtkBorder*)cPtr).bottom = propval;
  }

  /**
   * Allocates a new `GtkBorder` struct and initializes its elements to zero.
   * Returns: a newly allocated `GtkBorder` struct.
   *   Free with [Gtk.Border.free]
   */
  this()
  {
    GtkBorder* _cretval;
    _cretval = gtk_border_new();
    this(_cretval, true);
  }

  /**
   * Copies a `GtkBorder`.
   * Returns: a copy of border_.
   */
  Border copy()
  {
    GtkBorder* _cretval;
    _cretval = gtk_border_copy(cast(GtkBorder*)cPtr);
    auto _retval = _cretval ? new Border(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
