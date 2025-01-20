module Gtk.BoxLayout;

import Gid.gid;
import Gtk.LayoutManager;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkBoxLayout` is a layout manager that arranges children in a single
 * row or column.
 * Whether it is a row or column depends on the value of its
 * [Gtk.Orientable.orientation] property. Within the other dimension
 * all children all allocated the same size. The `GtkBoxLayout` will respect
 * the [Gtk.Widget.halign] and [Gtk.Widget.valign]
 * properties of each child widget.
 * If you want all children to be assigned the same size, you can use
 * the [Gtk.BoxLayout.homogeneous] property.
 * If you want to specify the amount of space placed between each child,
 * you can use the [Gtk.BoxLayout.spacing] property.
 */
class BoxLayout : LayoutManager, Orientable
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
    return gtk_box_layout_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();

  /**
   * Creates a new `GtkBoxLayout`.
   * Params:
   *   orientation = the orientation for the new layout
   * Returns: a new box layout
   */
  this(Orientation orientation)
  {
    GtkLayoutManager* _cretval;
    _cretval = gtk_box_layout_new(orientation);
    this(_cretval, true);
  }

  /**
   * Gets the value set by [Gtk.BoxLayout.setBaselineChild].
   * Returns: the index of the child that determines the baseline
   *   in vertical layout, or -1
   */
  int getBaselineChild()
  {
    int _retval;
    _retval = gtk_box_layout_get_baseline_child(cast(GtkBoxLayout*)cPtr);
    return _retval;
  }

  /**
   * Gets the value set by [Gtk.BoxLayout.setBaselinePosition].
   * Returns: the baseline position
   */
  BaselinePosition getBaselinePosition()
  {
    GtkBaselinePosition _cretval;
    _cretval = gtk_box_layout_get_baseline_position(cast(GtkBoxLayout*)cPtr);
    BaselinePosition _retval = cast(BaselinePosition)_cretval;
    return _retval;
  }

  /**
   * Returns whether the layout is set to be homogeneous.
   * Returns: %TRUE if the layout is homogeneous
   */
  bool getHomogeneous()
  {
    bool _retval;
    _retval = gtk_box_layout_get_homogeneous(cast(GtkBoxLayout*)cPtr);
    return _retval;
  }

  /**
   * Returns the space that box_layout puts between children.
   * Returns: the spacing of the layout
   */
  uint getSpacing()
  {
    uint _retval;
    _retval = gtk_box_layout_get_spacing(cast(GtkBoxLayout*)cPtr);
    return _retval;
  }

  /**
   * Sets the index of the child that determines the baseline
   * in vertical layout.
   * Params:
   *   child = the child position, or -1
   */
  void setBaselineChild(int child)
  {
    gtk_box_layout_set_baseline_child(cast(GtkBoxLayout*)cPtr, child);
  }

  /**
   * Sets the baseline position of a box layout.
   * The baseline position affects only horizontal boxes with at least one
   * baseline aligned child. If there is more vertical space available than
   * requested, and the baseline is not allocated by the parent then the
   * given position is used to allocate the baseline within the extra
   * space available.
   * Params:
   *   position = a `GtkBaselinePosition`
   */
  void setBaselinePosition(BaselinePosition position)
  {
    gtk_box_layout_set_baseline_position(cast(GtkBoxLayout*)cPtr, position);
  }

  /**
   * Sets whether the box layout will allocate the same
   * size to all children.
   * Params:
   *   homogeneous = %TRUE to set the box layout as homogeneous
   */
  void setHomogeneous(bool homogeneous)
  {
    gtk_box_layout_set_homogeneous(cast(GtkBoxLayout*)cPtr, homogeneous);
  }

  /**
   * Sets how much spacing to put between children.
   * Params:
   *   spacing = the spacing to apply between children
   */
  void setSpacing(uint spacing)
  {
    gtk_box_layout_set_spacing(cast(GtkBoxLayout*)cPtr, spacing);
  }
}
