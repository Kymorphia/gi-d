module Gtk.DragIcon;

import GObject.ObjectG;
import GObject.Value;
import Gdk.Drag;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkDragIcon` is a `GtkRoot` implementation for drag icons.
 * A drag icon moves with the pointer during a Drag-and-Drop operation
 * and is destroyed when the drag ends.
 * To set up a drag icon and associate it with an ongoing drag operation,
 * use [Gtk.DragIcon.getForDrag] to get the icon for a drag. You can
 * then use it like any other widget and use [Gtk.DragIcon.setChild]
 * to set whatever widget should be used for the drag icon.
 * Keep in mind that drag icons do not allow user input.
 */
class DragIcon : Widget, Native, Root
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
    return gtk_drag_icon_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin NativeT!();
  mixin RootT!();

  /**
   * Creates a widget that can be used as a drag icon for the given
   * value.
   * Supported types include strings, `GdkRGBA` and `GtkTextBuffer`.
   * If GTK does not know how to create a widget for a given value,
   * it will return %NULL.
   * This method is used to set the default drag icon on drag-and-drop
   * operations started by `GtkDragSource`, so you don't need to set
   * a drag icon using this function there.
   * Params:
   *   value = a `GValue`
   * Returns: A new `GtkWidget`
   *   for displaying value as a drag icon.
   */
  static Widget createWidgetForValue(Value value)
  {
    GtkWidget* _cretval;
    _cretval = gtk_drag_icon_create_widget_for_value(value ? cast(GValue*)value.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the `GtkDragIcon` in use with drag.
   * If no drag icon exists yet, a new one will be created
   * and shown.
   * Params:
   *   drag = a `GdkDrag`
   * Returns: the `GtkDragIcon`
   */
  static Widget getForDrag(Drag drag)
  {
    GtkWidget* _cretval;
    _cretval = gtk_drag_icon_get_for_drag(drag ? cast(GdkDrag*)drag.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GtkDragIcon` that shows paintable, and associates
   * it with the drag operation.
   * The hotspot position on the paintable is aligned with the
   * hotspot of the cursor.
   * Params:
   *   drag = a `GdkDrag`
   *   paintable = a `GdkPaintable` to display
   *   hotX = X coordinate of the hotspot
   *   hotY = Y coordinate of the hotspot
   */
  static void setFromPaintable(Drag drag, Paintable paintable, int hotX, int hotY)
  {
    gtk_drag_icon_set_from_paintable(drag ? cast(GdkDrag*)drag.cPtr(false) : null, paintable ? cast(GdkPaintable*)(cast(ObjectG)paintable).cPtr(false) : null, hotX, hotY);
  }

  /**
   * Gets the widget currently used as drag icon.
   * Returns: The drag icon
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_drag_icon_get_child(cast(GtkDragIcon*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the widget to display as the drag icon.
   * Params:
   *   child = a `GtkWidget`
   */
  void setChild(Widget child)
  {
    gtk_drag_icon_set_child(cast(GtkDragIcon*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }
}
