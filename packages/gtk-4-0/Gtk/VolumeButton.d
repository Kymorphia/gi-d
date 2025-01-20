module Gtk.VolumeButton;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleRange;
import Gtk.AccessibleRangeT;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.ScaleButton;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkVolumeButton` is a `GtkScaleButton` subclass tailored for
 * volume control.
 * ![An example GtkVolumeButton](volumebutton.png)

 * Deprecated: This widget will be removed in GTK 5
 */
class VolumeButton : ScaleButton
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_volume_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkVolumeButton`.
   * The button has a range between 0.0 and 1.0, with a stepping of 0.02.
   * Volume values can be obtained and modified using the functions from
   * [Gtk.ScaleButton].
   * Returns: a new `GtkVolumeButton`

   * Deprecated: This widget will be removed in GTK 5
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_volume_button_new();
    this(_cretval, false);
  }
}
