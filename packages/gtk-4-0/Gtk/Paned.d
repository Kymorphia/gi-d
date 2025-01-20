module Gtk.Paned;

import GObject.DClosure;
import GObject.ObjectG;
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
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A widget with two panes, arranged either horizontally or vertically.
 * ![An example GtkPaned](panes.png)
 * The division between the two panes is adjustable by the user
 * by dragging a handle.
 * Child widgets are added to the panes of the widget with
 * [Gtk.Paned.setStartChild] and [Gtk.Paned.setEndChild].
 * The division between the two children is set by default from the size
 * requests of the children, but it can be adjusted by the user.
 * A paned widget draws a separator between the two child widgets and a
 * small handle that the user can drag to adjust the division. It does not
 * draw any relief around the children or around the separator. $(LPAREN)The space
 * in which the separator is called the gutter.$(RPAREN) Often, it is useful to put
 * each child inside a [Gtk.Frame] so that the gutter appears as a
 * ridge. No separator is drawn if one of the children is missing.
 * Each child has two options that can be set, "resize" and "shrink". If
 * "resize" is true then, when the `GtkPaned` is resized, that child will
 * expand or shrink along with the paned widget. If "shrink" is true, then
 * that child can be made smaller than its requisition by the user.
 * Setting "shrink" to false allows the application to set a minimum size.
 * If "resize" is false for both children, then this is treated as if
 * "resize" is true for both children.
 * The application can set the position of the slider as if it were set
 * by the user, by calling [Gtk.Paned.setPosition].
 * # CSS nodes
 * ```
 * paned
 * ├── <child>
 * ├── separator[.wide]
 * ╰── <child>
 * ```
 * `GtkPaned` has a main CSS node with name paned, and a subnode for
 * the separator with name separator. The subnode gets a .wide style
 * class when the paned is supposed to be wide.
 * In horizontal orientation, the nodes are arranged based on the text
 * direction, so in left-to-right mode, :first-child will select the
 * leftmost child, while it will select the rightmost child in
 * RTL layouts.
 * ## Creating a paned widget with minimum sizes.
 * ```c
 * GtkWidget *hpaned \= gtk_paned_new $(LPAREN)GTK_ORIENTATION_HORIZONTAL$(RPAREN);
 * GtkWidget *frame1 \= gtk_frame_new $(LPAREN)NULL$(RPAREN);
 * GtkWidget *frame2 \= gtk_frame_new $(LPAREN)NULL$(RPAREN);
 * gtk_widget_set_size_request $(LPAREN)hpaned, 200, -1$(RPAREN);
 * gtk_paned_set_start_child $(LPAREN)GTK_PANED $(LPAREN)hpaned$(RPAREN), frame1$(RPAREN);
 * gtk_paned_set_resize_start_child $(LPAREN)GTK_PANED $(LPAREN)hpaned$(RPAREN), TRUE$(RPAREN);
 * gtk_paned_set_shrink_start_child $(LPAREN)GTK_PANED $(LPAREN)hpaned$(RPAREN), FALSE$(RPAREN);
 * gtk_widget_set_size_request $(LPAREN)frame1, 50, -1$(RPAREN);
 * gtk_paned_set_end_child $(LPAREN)GTK_PANED $(LPAREN)hpaned$(RPAREN), frame2$(RPAREN);
 * gtk_paned_set_resize_end_child $(LPAREN)GTK_PANED $(LPAREN)hpaned$(RPAREN), FALSE$(RPAREN);
 * gtk_paned_set_shrink_end_child $(LPAREN)GTK_PANED $(LPAREN)hpaned$(RPAREN), FALSE$(RPAREN);
 * gtk_widget_set_size_request $(LPAREN)frame2, 50, -1$(RPAREN);
 * ```
 */
class Paned : Widget, AccessibleRange, Orientable
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
    return gtk_paned_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleRangeT!();
  mixin OrientableT!();

  /**
   * Creates a new `GtkPaned` widget.
   * Params:
   *   orientation = the paned’s orientation.
   * Returns: the newly created paned widget
   */
  this(Orientation orientation)
  {
    GtkWidget* _cretval;
    _cretval = gtk_paned_new(orientation);
    this(_cretval, false);
  }

  /**
   * Retrieves the end child of the given `GtkPaned`.
   * Returns: the end child widget
   */
  Widget getEndChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_paned_get_end_child(cast(GtkPaned*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the position of the divider between the two panes.
   * Returns: the position of the divider, in pixels
   */
  int getPosition()
  {
    int _retval;
    _retval = gtk_paned_get_position(cast(GtkPaned*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the propertyGtk.Paned:end-child can be resized.
   * Returns: true if the end child is resizable
   */
  bool getResizeEndChild()
  {
    bool _retval;
    _retval = gtk_paned_get_resize_end_child(cast(GtkPaned*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the propertyGtk.Paned:start-child can be resized.
   * Returns: true if the start child is resizable
   */
  bool getResizeStartChild()
  {
    bool _retval;
    _retval = gtk_paned_get_resize_start_child(cast(GtkPaned*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the propertyGtk.Paned:end-child can shrink.
   * Returns: true if the end child is shrinkable
   */
  bool getShrinkEndChild()
  {
    bool _retval;
    _retval = gtk_paned_get_shrink_end_child(cast(GtkPaned*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the propertyGtk.Paned:start-child can shrink.
   * Returns: true if the start child is shrinkable
   */
  bool getShrinkStartChild()
  {
    bool _retval;
    _retval = gtk_paned_get_shrink_start_child(cast(GtkPaned*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the start child of the given `GtkPaned`.
   * Returns: the start child widget
   */
  Widget getStartChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_paned_get_start_child(cast(GtkPaned*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the separator should be wide.
   * Returns: %TRUE if the paned should have a wide handle
   */
  bool getWideHandle()
  {
    bool _retval;
    _retval = gtk_paned_get_wide_handle(cast(GtkPaned*)cPtr);
    return _retval;
  }

  /**
   * Sets the end child of paned to child.
   * If child is `NULL`, the existing child will be removed.
   * Params:
   *   child = the widget to add
   */
  void setEndChild(Widget child)
  {
    gtk_paned_set_end_child(cast(GtkPaned*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the position of the divider between the two panes.
   * Params:
   *   position = pixel position of divider, a negative value means that the position
   *     is unset
   */
  void setPosition(int position)
  {
    gtk_paned_set_position(cast(GtkPaned*)cPtr, position);
  }

  /**
   * Sets whether the propertyGtk.Paned:end-child can be resized.
   * Params:
   *   resize = true to let the end child be resized
   */
  void setResizeEndChild(bool resize)
  {
    gtk_paned_set_resize_end_child(cast(GtkPaned*)cPtr, resize);
  }

  /**
   * Sets whether the propertyGtk.Paned:start-child can be resized.
   * Params:
   *   resize = true to let the start child be resized
   */
  void setResizeStartChild(bool resize)
  {
    gtk_paned_set_resize_start_child(cast(GtkPaned*)cPtr, resize);
  }

  /**
   * Sets whether the propertyGtk.Paned:end-child can shrink.
   * Params:
   *   resize = true to let the end child be shrunk
   */
  void setShrinkEndChild(bool resize)
  {
    gtk_paned_set_shrink_end_child(cast(GtkPaned*)cPtr, resize);
  }

  /**
   * Sets whether the propertyGtk.Paned:start-child can shrink.
   * Params:
   *   resize = true to let the start child be shrunk
   */
  void setShrinkStartChild(bool resize)
  {
    gtk_paned_set_shrink_start_child(cast(GtkPaned*)cPtr, resize);
  }

  /**
   * Sets the start child of paned to child.
   * If child is `NULL`, the existing child will be removed.
   * Params:
   *   child = the widget to add
   */
  void setStartChild(Widget child)
  {
    gtk_paned_set_start_child(cast(GtkPaned*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether the separator should be wide.
   * Params:
   *   wide = the new value for the propertyGtk.Paned:wide-handle property
   */
  void setWideHandle(bool wide)
  {
    gtk_paned_set_wide_handle(cast(GtkPaned*)cPtr, wide);
  }

  /**
   * Emitted to accept the current position of the handle when
   * moving it using key bindings.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Return</kbd> or
   * <kbd>Space</kbd>.
   *   paned = the instance the signal is connected to
   * Returns:
   */
  alias AcceptPositionCallback = bool delegate(Paned paned);

  /**
   * Connect to AcceptPosition signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectAcceptPosition(AcceptPositionCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto paned = getVal!Paned(_paramVals);
      _retval = _dgClosure.dlg(paned);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("accept-position", closure, after);
  }

  /**
   * Emitted to cancel moving the position of the handle using key
   * bindings.
   * The position of the handle will be reset to the value prior to
   * moving it.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Escape</kbd>.
   *   paned = the instance the signal is connected to
   * Returns:
   */
  alias CancelPositionCallback = bool delegate(Paned paned);

  /**
   * Connect to CancelPosition signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCancelPosition(CancelPositionCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto paned = getVal!Paned(_paramVals);
      _retval = _dgClosure.dlg(paned);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cancel-position", closure, after);
  }

  /**
   * Emitted to cycle the focus between the children of the paned.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding is <kbd>F6</kbd>.
   * Params
   *   reversed = whether cycling backward or forward
   *   paned = the instance the signal is connected to
   * Returns:
   */
  alias CycleChildFocusCallback = bool delegate(bool reversed, Paned paned);

  /**
   * Connect to CycleChildFocus signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCycleChildFocus(CycleChildFocusCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto paned = getVal!Paned(_paramVals);
      auto reversed = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(reversed, paned);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cycle-child-focus", closure, after);
  }

  /**
   * Emitted to cycle whether the paned should grab focus to allow
   * the user to change position of the handle by using key bindings.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>F8</kbd>.
   * Params
   *   reversed = whether cycling backward or forward
   *   paned = the instance the signal is connected to
   * Returns:
   */
  alias CycleHandleFocusCallback = bool delegate(bool reversed, Paned paned);

  /**
   * Connect to CycleHandleFocus signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCycleHandleFocus(CycleHandleFocusCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto paned = getVal!Paned(_paramVals);
      auto reversed = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(reversed, paned);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cycle-handle-focus", closure, after);
  }

  /**
   * Emitted to move the handle with key bindings.
   * This is a [keybinding signal](class.SignalAction.html).
   * Params
   *   scrollType = a `GtkScrollType`
   *   paned = the instance the signal is connected to
   * Returns:
   */
  alias MoveHandleCallback = bool delegate(ScrollType scrollType, Paned paned);

  /**
   * Connect to MoveHandle signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMoveHandle(MoveHandleCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto paned = getVal!Paned(_paramVals);
      auto scrollType = getVal!ScrollType(&_paramVals[1]);
      _retval = _dgClosure.dlg(scrollType, paned);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-handle", closure, after);
  }

  /**
   * Emitted to accept the current position of the handle and then
   * move focus to the next widget in the focus chain.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding is <kbd>Tab</kbd>.
   *   paned = the instance the signal is connected to
   * Returns:
   */
  alias ToggleHandleFocusCallback = bool delegate(Paned paned);

  /**
   * Connect to ToggleHandleFocus signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggleHandleFocus(ToggleHandleFocusCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto paned = getVal!Paned(_paramVals);
      _retval = _dgClosure.dlg(paned);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-handle-focus", closure, after);
  }
}
