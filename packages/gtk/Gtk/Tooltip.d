module Gtk.Tooltip;

import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.Rectangle;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkTooltip` is an object representing a widget tooltip.
 * Basic tooltips can be realized simply by using
 * [Gtk.Widget.setTooltipText] or
 * [Gtk.Widget.setTooltipMarkup] without
 * any explicit tooltip object.
 * When you need a tooltip with a little more fancy contents,
 * like adding an image, or you want the tooltip to have different
 * contents per `GtkTreeView` row or cell, you will have to do a
 * little more work:
 * - Set the property@Gtk.Widget:has-tooltip property to %TRUE.
 * This will make GTK monitor the widget for motion and related events
 * which are needed to determine when and where to show a tooltip.
 * - Connect to the signal@Gtk.Widget::query-tooltip signal.
 * This signal will be emitted when a tooltip is supposed to be shown.
 * One of the arguments passed to the signal handler is a `GtkTooltip`
 * object. This is the object that we are about to display as a tooltip,
 * and can be manipulated in your callback using functions like
 * [Gtk.Tooltip.setIcon]. There are functions for setting
 * the tooltip’s markup, setting an image from a named icon, or even
 * putting in a custom widget.
 * - Return %TRUE from your ::query-tooltip handler. This causes the tooltip
 * to be show. If you return %FALSE, it will not be shown.
 */
class Tooltip : ObjectG
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
    return gtk_tooltip_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Replaces the widget packed into the tooltip with
   * custom_widget. custom_widget does not get destroyed when the tooltip goes
   * away.
   * By default a box with a `GtkImage` and `GtkLabel` is embedded in
   * the tooltip, which can be configured using [Gtk.Tooltip.setMarkup]
   * and [Gtk.Tooltip.setIcon].
   * Params:
   *   customWidget = a `GtkWidget`, or %NULL to unset the old custom widget.
   */
  void setCustom(Widget customWidget)
  {
    gtk_tooltip_set_custom(cast(GtkTooltip*)cPtr, customWidget ? cast(GtkWidget*)customWidget.cPtr(false) : null);
  }

  /**
   * Sets the icon of the tooltip $(LPAREN)which is in front of the text$(RPAREN) to be
   * paintable.  If paintable is %NULL, the image will be hidden.
   * Params:
   *   paintable = a `GdkPaintable`
   */
  void setIcon(Paintable paintable)
  {
    gtk_tooltip_set_icon(cast(GtkTooltip*)cPtr, paintable ? cast(GdkPaintable*)(cast(ObjectG)paintable).cPtr(false) : null);
  }

  /**
   * Sets the icon of the tooltip $(LPAREN)which is in front of the text$(RPAREN)
   * to be the icon indicated by gicon with the size indicated
   * by size. If gicon is %NULL, the image will be hidden.
   * Params:
   *   gicon = a `GIcon` representing the icon
   */
  void setIconFromGicon(Icon gicon)
  {
    gtk_tooltip_set_icon_from_gicon(cast(GtkTooltip*)cPtr, gicon ? cast(GIcon*)(cast(ObjectG)gicon).cPtr(false) : null);
  }

  /**
   * Sets the icon of the tooltip $(LPAREN)which is in front of the text$(RPAREN) to be
   * the icon indicated by icon_name with the size indicated
   * by size.  If icon_name is %NULL, the image will be hidden.
   * Params:
   *   iconName = an icon name
   */
  void setIconFromIconName(string iconName)
  {
    const(char)* _iconName = iconName.toCString(false);
    gtk_tooltip_set_icon_from_icon_name(cast(GtkTooltip*)cPtr, _iconName);
  }

  /**
   * Sets the text of the tooltip to be markup.
   * The string must be marked up with Pango markup.
   * If markup is %NULL, the label will be hidden.
   * Params:
   *   markup = a string with Pango markup or %NLL
   */
  void setMarkup(string markup)
  {
    const(char)* _markup = markup.toCString(false);
    gtk_tooltip_set_markup(cast(GtkTooltip*)cPtr, _markup);
  }

  /**
   * Sets the text of the tooltip to be text.
   * If text is %NULL, the label will be hidden.
   * See also [Gtk.Tooltip.setMarkup].
   * Params:
   *   text = a text string
   */
  void setText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_tooltip_set_text(cast(GtkTooltip*)cPtr, _text);
  }

  /**
   * Sets the area of the widget, where the contents of this tooltip apply,
   * to be rect $(LPAREN)in widget coordinates$(RPAREN).  This is especially useful for
   * properly setting tooltips on `GtkTreeView` rows and cells, `GtkIconViews`,
   * etc.
   * For setting tooltips on `GtkTreeView`, please refer to the convenience
   * functions for this: [Gtk.TreeView.setTooltipRow] and
   * [Gtk.TreeView.setTooltipCell].
   * Params:
   *   rect = a `GdkRectangle`
   */
  void setTipArea(Rectangle rect)
  {
    gtk_tooltip_set_tip_area(cast(GtkTooltip*)cPtr, rect ? cast(GdkRectangle*)rect.cPtr(false) : null);
  }
}
