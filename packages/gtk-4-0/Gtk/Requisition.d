module Gtk.Requisition;

import GLib.Boxed;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkRequisition` represents the desired size of a widget. See
 * [GtkWidget’s geometry management section](class.Widget.html#height-for-width-geometry-management) for
 * more information.
 */
class Requisition : Boxed
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
    return gtk_requisition_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int width()
  {
    return (cast(GtkRequisition*)cPtr).width;
  }

  @property void width(int propval)
  {
    (cast(GtkRequisition*)cPtr).width = propval;
  }

  @property int height()
  {
    return (cast(GtkRequisition*)cPtr).height;
  }

  @property void height(int propval)
  {
    (cast(GtkRequisition*)cPtr).height = propval;
  }

  /**
   * Allocates a new `GtkRequisition`.
   * The struct is initialized to zero.
   * Returns: a new empty `GtkRequisition`. The newly
   *   allocated `GtkRequisition` should be freed with
   *   [Gtk.Requisition.free]
   */
  this()
  {
    GtkRequisition* _cretval;
    _cretval = gtk_requisition_new();
    this(_cretval, true);
  }

  /**
   * Copies a `GtkRequisition`.
   * Returns: a copy of requisition
   */
  Requisition copy()
  {
    GtkRequisition* _cretval;
    _cretval = gtk_requisition_copy(cast(GtkRequisition*)cPtr);
    auto _retval = _cretval ? new Requisition(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
