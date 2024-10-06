module Gtk.FixedLayoutChild;

import Gid.gid;
import Gsk.Transform;
import Gtk.LayoutChild;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkLayoutChild` subclass for children in a `GtkFixedLayout`.
 */
class FixedLayoutChild : LayoutChild
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
    return gtk_fixed_layout_child_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves the transformation of the child.
   * Returns: a `GskTransform`
   */
  Transform getTransform()
  {
    GskTransform* _cretval;
    _cretval = gtk_fixed_layout_child_get_transform(cast(GtkFixedLayoutChild*)cPtr);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the transformation of the child of a `GtkFixedLayout`.
   * Params:
   *   transform = a `GskTransform`
   */
  void setTransform(Transform transform)
  {
    gtk_fixed_layout_child_set_transform(cast(GtkFixedLayoutChild*)cPtr, transform ? cast(GskTransform*)transform.cPtr(false) : null);
  }
}
