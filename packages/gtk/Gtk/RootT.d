module Gtk.RootT;

public import Gtk.RootIfaceProxy;
public import GObject.ObjectG;
public import Gdk.Display;
public import Gid.gid;
public import Gtk.Types;
public import Gtk.Widget;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * `GtkRoot` is the interface implemented by all widgets that can act as a toplevel
 * widget.
 * The root widget takes care of providing the connection to the windowing system
 * and manages layout, drawing and event delivery for its widget hierarchy.
 * The obvious example of a `GtkRoot` is `GtkWindow`.
 * To get the display to which a `GtkRoot` belongs, use
 * [Gtk.Root.getDisplay].
 * `GtkRoot` also maintains the location of keyboard focus inside its widget
 * hierarchy, with [Gtk.Root.setFocus] and [Gtk.Root.getFocus].
 */
template RootT()
{

  /**
   * Returns the display that this `GtkRoot` is on.
   * Returns: the display of root
   */
  override Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gtk_root_get_display(cast(GtkRoot*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the current focused widget within the root.
   * Note that this is the widget that would have the focus
   * if the root is active; if the root is not focused then
   * `gtk_widget_has_focus $(LPAREN)widget$(RPAREN)` will be %FALSE for the
   * widget.
   * Returns: the currently focused widget
   */
  override Widget getFocus()
  {
    GtkWidget* _cretval;
    _cretval = gtk_root_get_focus(cast(GtkRoot*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * If focus is not the current focus widget, and is focusable, sets
   * it as the focus widget for the root.
   * If focus is %NULL, unsets the focus widget for the root.
   * To set the focus to a particular widget in the root, it is usually
   * more convenient to use [Gtk.Widget.grabFocus] instead of
   * this function.
   * Params:
   *   focus = widget to be the new focus widget, or %NULL
   *     to unset the focus widget
   */
  override void setFocus(Widget focus)
  {
    gtk_root_set_focus(cast(GtkRoot*)cPtr, focus ? cast(GtkWidget*)focus.cPtr(false) : null);
  }
}
