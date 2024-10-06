module Gtk.OverlayLayout;

import Gid.gid;
import Gtk.LayoutManager;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkOverlayLayout` is the layout manager used by [Gtk.Overlay].
 * It places widgets as overlays on top of the main child.
 * This is not a reusable layout manager, since it expects its widget
 * to be a `GtkOverlay`. It is only listed here so that its layout
 * properties get documented.
 */
class OverlayLayout : LayoutManager
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_overlay_layout_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkOverlayLayout` instance.
   * Returns: the newly created instance
   */
  this()
  {
    GtkLayoutManager* _cretval;
    _cretval = gtk_overlay_layout_new();
    this(_cretval, true);
  }
}
