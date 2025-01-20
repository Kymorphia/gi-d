module Gtk.SizeGroup;

import GLib.SList;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSizeGroup` groups widgets together so they all request the same size.
 * This is typically useful when you want a column of widgets to have the
 * same size, but you can’t use a `GtkGrid`.
 * In detail, the size requested for each widget in a `GtkSizeGroup` is
 * the maximum of the sizes that would have been requested for each
 * widget in the size group if they were not in the size group. The mode
 * of the size group $(LPAREN)see [Gtk.SizeGroup.setMode]$(RPAREN) determines whether
 * this applies to the horizontal size, the vertical size, or both sizes.
 * Note that size groups only affect the amount of space requested, not
 * the size that the widgets finally receive. If you want the widgets in
 * a `GtkSizeGroup` to actually be the same size, you need to pack them in
 * such a way that they get the size they request and not more.
 * `GtkSizeGroup` objects are referenced by each widget in the size group,
 * so once you have added all widgets to a `GtkSizeGroup`, you can drop
 * the initial reference to the size group with [GObject.ObjectG.unref]. If the
 * widgets in the size group are subsequently destroyed, then they will
 * be removed from the size group and drop their references on the size
 * group; when all widgets have been removed, the size group will be
 * freed.
 * Widgets can be part of multiple size groups; GTK will compute the
 * horizontal size of a widget from the horizontal requisition of all
 * widgets that can be reached from the widget by a chain of size groups
 * of type %GTK_SIZE_GROUP_HORIZONTAL or %GTK_SIZE_GROUP_BOTH, and the
 * vertical size from the vertical requisition of all widgets that can be
 * reached from the widget by a chain of size groups of type
 * %GTK_SIZE_GROUP_VERTICAL or %GTK_SIZE_GROUP_BOTH.
 * Note that only non-contextual sizes of every widget are ever consulted
 * by size groups $(LPAREN)since size groups have no knowledge of what size a widget
 * will be allocated in one dimension, it cannot derive how much height
 * a widget will receive for a given width$(RPAREN). When grouping widgets that
 * trade height for width in mode %GTK_SIZE_GROUP_VERTICAL or %GTK_SIZE_GROUP_BOTH:
 * the height for the minimum width will be the requested height for all
 * widgets in the group. The same is of course true when horizontally grouping
 * width for height widgets.
 * Widgets that trade height-for-width should set a reasonably large minimum
 * width by way of property@Gtk.Label:width-chars for instance. Widgets with
 * static sizes as well as widgets that grow $(LPAREN)such as ellipsizing text$(RPAREN) need no
 * such considerations.
 * # GtkSizeGroup as GtkBuildable
 * Size groups can be specified in a UI definition by placing an `<object>`
 * element with `class\="GtkSizeGroup"` somewhere in the UI definition. The
 * widgets that belong to the size group are specified by a `<widgets>` element
 * that may contain multiple `<widget>` elements, one for each member of the
 * size group. The ”name” attribute gives the id of the widget.
 * An example of a UI definition fragment with `GtkSizeGroup`:
 * ```xml
 * <object class\="GtkSizeGroup">
 * <property name\="mode">horizontal</property>
 * <widgets>
 * <widget name\="radio1"/>
 * <widget name\="radio2"/>
 * </widgets>
 * </object>
 * ```
 */
class SizeGroup : ObjectG, Buildable
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
    return gtk_size_group_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!();

  /**
   * Create a new `GtkSizeGroup`.
   * Params:
   *   mode = the mode for the new size group.
   * Returns: a newly created `GtkSizeGroup`
   */
  this(SizeGroupMode mode)
  {
    GtkSizeGroup* _cretval;
    _cretval = gtk_size_group_new(mode);
    this(_cretval, true);
  }

  /**
   * Adds a widget to a `GtkSizeGroup`.
   * In the future, the requisition
   * of the widget will be determined as the maximum of its requisition
   * and the requisition of the other widgets in the size group.
   * Whether this applies horizontally, vertically, or in both directions
   * depends on the mode of the size group.
   * See [Gtk.SizeGroup.setMode].
   * When the widget is destroyed or no longer referenced elsewhere, it
   * will be removed from the size group.
   * Params:
   *   widget = the `GtkWidget` to add
   */
  void addWidget(Widget widget)
  {
    gtk_size_group_add_widget(cast(GtkSizeGroup*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Gets the current mode of the size group.
   * Returns: the current mode of the size group.
   */
  SizeGroupMode getMode()
  {
    GtkSizeGroupMode _cretval;
    _cretval = gtk_size_group_get_mode(cast(GtkSizeGroup*)cPtr);
    SizeGroupMode _retval = cast(SizeGroupMode)_cretval;
    return _retval;
  }

  /**
   * Returns the list of widgets associated with size_group.
   * Returns: a `GSList` of
   *   widgets. The list is owned by GTK and should not be modified.
   */
  SList!(Widget) getWidgets()
  {
    GSList* _cretval;
    _cretval = gtk_size_group_get_widgets(cast(GtkSizeGroup*)cPtr);
    SList!(Widget) _retval = new SList!(Widget)(cast(GSList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Removes a widget from a `GtkSizeGroup`.
   * Params:
   *   widget = the `GtkWidget` to remove
   */
  void removeWidget(Widget widget)
  {
    gtk_size_group_remove_widget(cast(GtkSizeGroup*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Sets the `GtkSizeGroupMode` of the size group.
   * The mode of the size group determines whether the widgets in the
   * size group should all have the same horizontal requisition
   * $(LPAREN)%GTK_SIZE_GROUP_HORIZONTAL$(RPAREN) all have the same vertical requisition
   * $(LPAREN)%GTK_SIZE_GROUP_VERTICAL$(RPAREN), or should all have the same requisition
   * in both directions $(LPAREN)%GTK_SIZE_GROUP_BOTH$(RPAREN).
   * Params:
   *   mode = the mode to set for the size group.
   */
  void setMode(SizeGroupMode mode)
  {
    gtk_size_group_set_mode(cast(GtkSizeGroup*)cPtr, mode);
  }
}
