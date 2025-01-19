module Gtk.WidgetPaintable;

import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkWidgetPaintable` is a `GdkPaintable` that displays the contents
 * of a widget.
 * `GtkWidgetPaintable` will also take care of the widget not being in a
 * state where it can be drawn $(LPAREN)like when it isn't shown$(RPAREN) and just draw
 * nothing or where it does not have a size $(LPAREN)like when it is hidden$(RPAREN) and
 * report no size in that case.
 * Of course, `GtkWidgetPaintable` allows you to monitor widgets for size
 * changes by emitting the signal@Gdk.Paintable::invalidate-size signal
 * whenever the size of the widget changes as well as for visual changes by
 * emitting the signal@Gdk.Paintable::invalidate-contents signal whenever
 * the widget changes.
 * You can use a `GtkWidgetPaintable` everywhere a `GdkPaintable` is allowed,
 * including using it on a `GtkPicture` $(LPAREN)or one of its parents$(RPAREN) that it was
 * set on itself via [Gtk.Picture.setPaintable]. The paintable will take care
 * of recursion when this happens. If you do this however, ensure that the
 * property@Gtk.Picture:can-shrink property is set to %TRUE or you might
 * end up with an infinitely growing widget.
 */
class WidgetPaintable : ObjectG, Paintable
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
    return gtk_widget_paintable_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin PaintableT!();

  /**
   * Creates a new widget paintable observing the given widget.
   * Params:
   *   widget = a `GtkWidget`
   * Returns: a new `GtkWidgetPaintable`
   */
  this(Widget widget)
  {
    GdkPaintable* _cretval;
    _cretval = gtk_widget_paintable_new(widget ? cast(GtkWidget*)widget.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Returns the widget that is observed or %NULL if none.
   * Returns: the observed widget.
   */
  Widget getWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_widget_paintable_get_widget(cast(GtkWidgetPaintable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the widget that should be observed.
   * Params:
   *   widget = the widget to observe
   */
  void setWidget(Widget widget)
  {
    gtk_widget_paintable_set_widget(cast(GtkWidgetPaintable*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }
}
