module Gtk.Scrollbar;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkScrollbar` widget is a horizontal or vertical scrollbar.
 * ![An example GtkScrollbar](scrollbar.png)
 * Its position and movement are controlled by the adjustment that is passed to
 * or created by [Gtk.Scrollbar.new_]. See [Gtk.Adjustment] for more
 * details. The [Gtk.Adjustment.value] field sets the position of the
 * thumb and must be between [Gtk.Adjustment.lower] and
 * [Gtk.Adjustment.upper] - property@Gtk.Adjustment:page-size.
 * The property@Gtk.Adjustment:page-size represents the size of the visible
 * scrollable area.
 * The fields property@Gtk.Adjustment:step-increment and
 * property@Gtk.Adjustment:page-increment fields are added to or subtracted
 * from the [Gtk.Adjustment.value] when the user asks to move by a step
 * $(LPAREN)using e.g. the cursor arrow keys$(RPAREN) or by a page $(LPAREN)using e.g. the Page Down/Up
 * keys$(RPAREN).
 * # CSS nodes
 * ```
 * scrollbar
 * ╰── range[.fine-tune]
 * ╰── trough
 * ╰── slider
 * ```
 * `GtkScrollbar` has a main CSS node with name scrollbar and a subnode for its
 * contents. The main node gets the .horizontal or .vertical style classes applied,
 * depending on the scrollbar's orientation.
 * The range node gets the style class .fine-tune added when the scrollbar is
 * in 'fine-tuning' mode.
 * Other style classes that may be added to scrollbars inside
 * [Gtk.ScrolledWindow] include the positional classes $(LPAREN).left, .right,
 * .top, .bottom$(RPAREN) and style classes related to overlay scrolling $(LPAREN).overlay-indicator,
 * .dragging, .hovering$(RPAREN).
 * # Accessibility
 * `GtkScrollbar` uses the %GTK_ACCESSIBLE_ROLE_SCROLLBAR role.
 */
class Scrollbar : Widget, Orientable
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
    return gtk_scrollbar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();

  /**
   * Creates a new scrollbar with the given orientation.
   * Params:
   *   orientation = the scrollbar’s orientation.
   *   adjustment = the [Gtk.Adjustment] to use, or %NULL
   *     to create a new adjustment.
   * Returns: the new `GtkScrollbar`.
   */
  this(Orientation orientation, Adjustment adjustment)
  {
    GtkWidget* _cretval;
    _cretval = gtk_scrollbar_new(orientation, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
    this(_cretval, false);
  }

  /**
   * Returns the scrollbar's adjustment.
   * Returns: the scrollbar's adjustment
   */
  Adjustment getAdjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_scrollbar_get_adjustment(cast(GtkScrollbar*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Makes the scrollbar use the given adjustment.
   * Params:
   *   adjustment = the adjustment to set
   */
  void setAdjustment(Adjustment adjustment)
  {
    gtk_scrollbar_set_adjustment(cast(GtkScrollbar*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }
}
