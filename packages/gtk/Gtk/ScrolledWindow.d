module Gtk.ScrolledWindow;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkScrolledWindow` is a container that makes its child scrollable.
 * It does so using either internally added scrollbars or externally
 * associated adjustments, and optionally draws a frame around the child.
 * Widgets with native scrolling support, i.e. those whose classes implement
 * the [Gtk.Scrollable] interface, are added directly. For other types
 * of widget, the class [Gtk.Viewport] acts as an adaptor, giving
 * scrollability to other widgets. [Gtk.ScrolledWindow.setChild]
 * intelligently accounts for whether or not the added child is a `GtkScrollable`.
 * If it isn’t, then it wraps the child in a `GtkViewport`. Therefore, you can
 * just add any child widget and not worry about the details.
 * If [Gtk.ScrolledWindow.setChild] has added a `GtkViewport` for you,
 * it will be automatically removed when you unset the child.
 * Unless property@Gtk.ScrolledWindow:hscrollbar-policy and
 * property@Gtk.ScrolledWindow:vscrollbar-policy are %GTK_POLICY_NEVER or
 * %GTK_POLICY_EXTERNAL, `GtkScrolledWindow` adds internal `GtkScrollbar` widgets
 * around its child. The scroll position of the child, and if applicable the
 * scrollbars, is controlled by the [Gtk.ScrolledWindow.hadjustment]
 * and [Gtk.ScrolledWindow.vadjustment] that are associated with the
 * `GtkScrolledWindow`. See the docs on [Gtk.Scrollbar] for the details,
 * but note that the “step_increment” and “page_increment” fields are only
 * effective if the policy causes scrollbars to be present.
 * If a `GtkScrolledWindow` doesn’t behave quite as you would like, or
 * doesn’t have exactly the right layout, it’s very possible to set up
 * your own scrolling with `GtkScrollbar` and for example a `GtkGrid`.
 * # Touch support
 * `GtkScrolledWindow` has built-in support for touch devices. When a
 * touchscreen is used, swiping will move the scrolled window, and will
 * expose 'kinetic' behavior. This can be turned off with the
 * property@Gtk.ScrolledWindow:kinetic-scrolling property if it is undesired.
 * `GtkScrolledWindow` also displays visual 'overshoot' indication when
 * the content is pulled beyond the end, and this situation can be
 * captured with the signal@Gtk.ScrolledWindow::edge-overshot signal.
 * If no mouse device is present, the scrollbars will overlaid as
 * narrow, auto-hiding indicators over the content. If traditional
 * scrollbars are desired although no mouse is present, this behaviour
 * can be turned off with the property@Gtk.ScrolledWindow:overlay-scrolling
 * property.
 * # CSS nodes
 * `GtkScrolledWindow` has a main CSS node with name scrolledwindow.
 * It gets a .frame style class added when property@Gtk.ScrolledWindow:has-frame
 * is %TRUE.
 * It uses subnodes with names overshoot and undershoot to draw the overflow
 * and underflow indications. These nodes get the .left, .right, .top or .bottom
 * style class added depending on where the indication is drawn.
 * `GtkScrolledWindow` also sets the positional style classes $(LPAREN).left, .right,
 * .top, .bottom$(RPAREN) and style classes related to overlay scrolling
 * $(LPAREN).overlay-indicator, .dragging, .hovering$(RPAREN) on its scrollbars.
 * If both scrollbars are visible, the area where they meet is drawn
 * with a subnode named junction.
 * # Accessibility
 * Until GTK 4.10, `GtkScrolledWindow` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 * Starting from GTK 4.12, `GtkScrolledWindow` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
 */
class ScrolledWindow : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_scrolled_window_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new scrolled window.
   * Returns: a new scrolled window
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scrolled_window_new();
    this(_cretval, false);
  }

  /**
   * Gets the child widget of scrolled_window.
   * If the scrolled window automatically added a [Gtk.Viewport], this
   * function will return the viewport widget, and you can retrieve its child
   * using [Gtk.Viewport.getChild].
   * Returns: the child widget of scrolled_window
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scrolled_window_get_child(cast(GtkScrolledWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the horizontal scrollbar’s adjustment.
   * This is the adjustment used to connect the horizontal scrollbar
   * to the child widget’s horizontal scroll functionality.
   * Returns: the horizontal `GtkAdjustment`
   */
  Adjustment getHadjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_scrolled_window_get_hadjustment(cast(GtkScrolledWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the scrolled window draws a frame.
   * Returns: %TRUE if the scrolled_window has a frame
   */
  bool getHasFrame()
  {
    bool _retval;
    _retval = gtk_scrolled_window_get_has_frame(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns the horizontal scrollbar of scrolled_window.
   * Returns: the horizontal scrollbar of the scrolled window.
   */
  Widget getHscrollbar()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scrolled_window_get_hscrollbar(cast(GtkScrolledWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the specified kinetic scrolling behavior.
   * Returns: the scrolling behavior flags.
   */
  bool getKineticScrolling()
  {
    bool _retval;
    _retval = gtk_scrolled_window_get_kinetic_scrolling(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns the maximum content height set.
   * Returns: the maximum content height, or -1
   */
  int getMaxContentHeight()
  {
    int _retval;
    _retval = gtk_scrolled_window_get_max_content_height(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns the maximum content width set.
   * Returns: the maximum content width, or -1
   */
  int getMaxContentWidth()
  {
    int _retval;
    _retval = gtk_scrolled_window_get_max_content_width(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Gets the minimal content height of scrolled_window.
   * Returns: the minimal content height
   */
  int getMinContentHeight()
  {
    int _retval;
    _retval = gtk_scrolled_window_get_min_content_height(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Gets the minimum content width of scrolled_window.
   * Returns: the minimum content width
   */
  int getMinContentWidth()
  {
    int _retval;
    _retval = gtk_scrolled_window_get_min_content_width(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether overlay scrolling is enabled for this scrolled window.
   * Returns: %TRUE if overlay scrolling is enabled
   */
  bool getOverlayScrolling()
  {
    bool _retval;
    _retval = gtk_scrolled_window_get_overlay_scrolling(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Gets the placement of the contents with respect to the scrollbars.
   * Returns: the current placement value.
   */
  CornerType getPlacement()
  {
    GtkCornerType _cretval;
    _cretval = gtk_scrolled_window_get_placement(cast(GtkScrolledWindow*)cPtr);
    CornerType _retval = cast(CornerType)_cretval;
    return _retval;
  }

  /**
   * Retrieves the current policy values for the horizontal and vertical
   * scrollbars.
   * See [Gtk.ScrolledWindow.setPolicy].
   * Params:
   *   hscrollbarPolicy = location to store the policy
   *     for the horizontal scrollbar
   *   vscrollbarPolicy = location to store the policy
   *     for the vertical scrollbar
   */
  void getPolicy(out PolicyType hscrollbarPolicy, out PolicyType vscrollbarPolicy)
  {
    gtk_scrolled_window_get_policy(cast(GtkScrolledWindow*)cPtr, &hscrollbarPolicy, &vscrollbarPolicy);
  }

  /**
   * Reports whether the natural height of the child will be calculated
   * and propagated through the scrolled window’s requested natural height.
   * Returns: whether natural height propagation is enabled.
   */
  bool getPropagateNaturalHeight()
  {
    bool _retval;
    _retval = gtk_scrolled_window_get_propagate_natural_height(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Reports whether the natural width of the child will be calculated
   * and propagated through the scrolled window’s requested natural width.
   * Returns: whether natural width propagation is enabled.
   */
  bool getPropagateNaturalWidth()
  {
    bool _retval;
    _retval = gtk_scrolled_window_get_propagate_natural_width(cast(GtkScrolledWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns the vertical scrollbar’s adjustment.
   * This is the adjustment used to connect the vertical
   * scrollbar to the child widget’s vertical scroll functionality.
   * Returns: the vertical `GtkAdjustment`
   */
  Adjustment getVadjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_scrolled_window_get_vadjustment(cast(GtkScrolledWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the vertical scrollbar of scrolled_window.
   * Returns: the vertical scrollbar of the scrolled window.
   */
  Widget getVscrollbar()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scrolled_window_get_vscrollbar(cast(GtkScrolledWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the child widget of scrolled_window.
   * If child does not implement the [Gtk.Scrollable] interface,
   * the scrolled window will add child to a [Gtk.Viewport] instance
   * and then add the viewport as its child widget.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_scrolled_window_set_child(cast(GtkScrolledWindow*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the `GtkAdjustment` for the horizontal scrollbar.
   * Params:
   *   hadjustment = the `GtkAdjustment` to use, or %NULL to create a new one
   */
  void setHadjustment(Adjustment hadjustment)
  {
    gtk_scrolled_window_set_hadjustment(cast(GtkScrolledWindow*)cPtr, hadjustment ? cast(GtkAdjustment*)hadjustment.cPtr(false) : null);
  }

  /**
   * Changes the frame drawn around the contents of scrolled_window.
   * Params:
   *   hasFrame = whether to draw a frame around scrolled window contents
   */
  void setHasFrame(bool hasFrame)
  {
    gtk_scrolled_window_set_has_frame(cast(GtkScrolledWindow*)cPtr, hasFrame);
  }

  /**
   * Turns kinetic scrolling on or off.
   * Kinetic scrolling only applies to devices with source
   * %GDK_SOURCE_TOUCHSCREEN.
   * Params:
   *   kineticScrolling = %TRUE to enable kinetic scrolling
   */
  void setKineticScrolling(bool kineticScrolling)
  {
    gtk_scrolled_window_set_kinetic_scrolling(cast(GtkScrolledWindow*)cPtr, kineticScrolling);
  }

  /**
   * Sets the maximum height that scrolled_window should keep visible.
   * The scrolled_window will grow up to this height before it starts
   * scrolling the content.
   * It is a programming error to set the maximum content height to a value
   * smaller than propertyGtk.ScrolledWindow:min-content-height.
   * Params:
   *   height = the maximum content height
   */
  void setMaxContentHeight(int height)
  {
    gtk_scrolled_window_set_max_content_height(cast(GtkScrolledWindow*)cPtr, height);
  }

  /**
   * Sets the maximum width that scrolled_window should keep visible.
   * The scrolled_window will grow up to this width before it starts
   * scrolling the content.
   * It is a programming error to set the maximum content width to a
   * value smaller than propertyGtk.ScrolledWindow:min-content-width.
   * Params:
   *   width = the maximum content width
   */
  void setMaxContentWidth(int width)
  {
    gtk_scrolled_window_set_max_content_width(cast(GtkScrolledWindow*)cPtr, width);
  }

  /**
   * Sets the minimum height that scrolled_window should keep visible.
   * Note that this can and $(LPAREN)usually will$(RPAREN) be smaller than the minimum
   * size of the content.
   * It is a programming error to set the minimum content height to a
   * value greater than propertyGtk.ScrolledWindow:max-content-height.
   * Params:
   *   height = the minimal content height
   */
  void setMinContentHeight(int height)
  {
    gtk_scrolled_window_set_min_content_height(cast(GtkScrolledWindow*)cPtr, height);
  }

  /**
   * Sets the minimum width that scrolled_window should keep visible.
   * Note that this can and $(LPAREN)usually will$(RPAREN) be smaller than the minimum
   * size of the content.
   * It is a programming error to set the minimum content width to a
   * value greater than propertyGtk.ScrolledWindow:max-content-width.
   * Params:
   *   width = the minimal content width
   */
  void setMinContentWidth(int width)
  {
    gtk_scrolled_window_set_min_content_width(cast(GtkScrolledWindow*)cPtr, width);
  }

  /**
   * Enables or disables overlay scrolling for this scrolled window.
   * Params:
   *   overlayScrolling = whether to enable overlay scrolling
   */
  void setOverlayScrolling(bool overlayScrolling)
  {
    gtk_scrolled_window_set_overlay_scrolling(cast(GtkScrolledWindow*)cPtr, overlayScrolling);
  }

  /**
   * Sets the placement of the contents with respect to the scrollbars
   * for the scrolled window.
   * The default is %GTK_CORNER_TOP_LEFT, meaning the child is
   * in the top left, with the scrollbars underneath and to the right.
   * Other values in [Gtk] are %GTK_CORNER_TOP_RIGHT,
   * %GTK_CORNER_BOTTOM_LEFT, and %GTK_CORNER_BOTTOM_RIGHT.
   * See also [Gtk.ScrolledWindow.getPlacement] and
   * [Gtk.ScrolledWindow.unsetPlacement].
   * Params:
   *   windowPlacement = position of the child window
   */
  void setPlacement(CornerType windowPlacement)
  {
    gtk_scrolled_window_set_placement(cast(GtkScrolledWindow*)cPtr, windowPlacement);
  }

  /**
   * Sets the scrollbar policy for the horizontal and vertical scrollbars.
   * The policy determines when the scrollbar should appear; it is a value
   * from the [Gtk] enumeration. If %GTK_POLICY_ALWAYS, the
   * scrollbar is always present; if %GTK_POLICY_NEVER, the scrollbar is
   * never present; if %GTK_POLICY_AUTOMATIC, the scrollbar is present only
   * if needed $(LPAREN)that is, if the slider part of the bar would be smaller
   * than the trough — the display is larger than the page size$(RPAREN).
   * Params:
   *   hscrollbarPolicy = policy for horizontal bar
   *   vscrollbarPolicy = policy for vertical bar
   */
  void setPolicy(PolicyType hscrollbarPolicy, PolicyType vscrollbarPolicy)
  {
    gtk_scrolled_window_set_policy(cast(GtkScrolledWindow*)cPtr, hscrollbarPolicy, vscrollbarPolicy);
  }

  /**
   * Sets whether the natural height of the child should be calculated
   * and propagated through the scrolled window’s requested natural height.
   * Params:
   *   propagate = whether to propagate natural height
   */
  void setPropagateNaturalHeight(bool propagate)
  {
    gtk_scrolled_window_set_propagate_natural_height(cast(GtkScrolledWindow*)cPtr, propagate);
  }

  /**
   * Sets whether the natural width of the child should be calculated
   * and propagated through the scrolled window’s requested natural width.
   * Params:
   *   propagate = whether to propagate natural width
   */
  void setPropagateNaturalWidth(bool propagate)
  {
    gtk_scrolled_window_set_propagate_natural_width(cast(GtkScrolledWindow*)cPtr, propagate);
  }

  /**
   * Sets the `GtkAdjustment` for the vertical scrollbar.
   * Params:
   *   vadjustment = the `GtkAdjustment` to use, or %NULL to create a new one
   */
  void setVadjustment(Adjustment vadjustment)
  {
    gtk_scrolled_window_set_vadjustment(cast(GtkScrolledWindow*)cPtr, vadjustment ? cast(GtkAdjustment*)vadjustment.cPtr(false) : null);
  }

  /**
   * Unsets the placement of the contents with respect to the scrollbars.
   * If no window placement is set for a scrolled window,
   * it defaults to %GTK_CORNER_TOP_LEFT.
   */
  void unsetPlacement()
  {
    gtk_scrolled_window_unset_placement(cast(GtkScrolledWindow*)cPtr);
  }

  /**
   * Emitted whenever user initiated scrolling makes the scrolled
   * window firmly surpass the limits defined by the adjustment
   * in that orientation.
   * A similar behavior without edge resistance is provided by the
   * signalGtk.ScrolledWindow::edge-reached signal.
   * Note: The pos argument is LTR/RTL aware, so callers should be
   * aware too if intending to provide behavior on horizontal edges.
   * Params
   *   pos = edge side that was hit
   *   scrolledWindow = the instance the signal is connected to
   */
  alias EdgeOvershotCallback = void delegate(PositionType pos, ScrolledWindow scrolledWindow);

  /**
   * Connect to EdgeOvershot signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEdgeOvershot(EdgeOvershotCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto scrolledWindow = getVal!ScrolledWindow(_paramVals);
      auto pos = getVal!PositionType(&_paramVals[1]);
      _dgClosure.dlg(pos, scrolledWindow);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("edge-overshot", closure, after);
  }

  /**
   * Emitted whenever user-initiated scrolling makes the scrolled
   * window exactly reach the lower or upper limits defined by the
   * adjustment in that orientation.
   * A similar behavior with edge resistance is provided by the
   * signalGtk.ScrolledWindow::edge-overshot signal.
   * Note: The pos argument is LTR/RTL aware, so callers should be
   * aware too if intending to provide behavior on horizontal edges.
   * Params
   *   pos = edge side that was reached
   *   scrolledWindow = the instance the signal is connected to
   */
  alias EdgeReachedCallback = void delegate(PositionType pos, ScrolledWindow scrolledWindow);

  /**
   * Connect to EdgeReached signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEdgeReached(EdgeReachedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto scrolledWindow = getVal!ScrolledWindow(_paramVals);
      auto pos = getVal!PositionType(&_paramVals[1]);
      _dgClosure.dlg(pos, scrolledWindow);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("edge-reached", closure, after);
  }

  /**
   * Emitted when focus is moved away from the scrolled window by a
   * keybinding.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * `Ctrl + Tab` to move forward and `Ctrl + Shift + Tab` to
   * move backward.
   * Params
   *   directionType = either %GTK_DIR_TAB_FORWARD or
   *     %GTK_DIR_TAB_BACKWARD
   *   scrolledWindow = the instance the signal is connected to
   */
  alias MoveFocusOutCallback = void delegate(DirectionType directionType, ScrolledWindow scrolledWindow);

  /**
   * Connect to MoveFocusOut signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMoveFocusOut(MoveFocusOutCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto scrolledWindow = getVal!ScrolledWindow(_paramVals);
      auto directionType = getVal!DirectionType(&_paramVals[1]);
      _dgClosure.dlg(directionType, scrolledWindow);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-focus-out", closure, after);
  }

  /**
   * Emitted when a keybinding that scrolls is pressed.
   * This is a [keybinding signal](class.SignalAction.html).
   * The horizontal or vertical adjustment is updated which triggers a
   * signal that the scrolled window’s child may listen to and scroll itself.
   * Params
   *   scroll = a `GtkScrollType` describing how much to scroll
   *   horizontal = whether the keybinding scrolls the child
   *     horizontally or not
   *   scrolledWindow = the instance the signal is connected to
   * Returns:
   */
  alias ScrollChildCallback = bool delegate(ScrollType scroll, bool horizontal, ScrolledWindow scrolledWindow);

  /**
   * Connect to ScrollChild signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectScrollChild(ScrollChildCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto scrolledWindow = getVal!ScrolledWindow(_paramVals);
      auto scroll = getVal!ScrollType(&_paramVals[1]);
      auto horizontal = getVal!bool(&_paramVals[2]);
      _retval = _dgClosure.dlg(scroll, horizontal, scrolledWindow);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("scroll-child", closure, after);
  }
}
