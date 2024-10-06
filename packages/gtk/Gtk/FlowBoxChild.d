module Gtk.FlowBoxChild;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFlowBoxChild` is the kind of widget that can be added to a `GtkFlowBox`.
 */
class FlowBoxChild : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_flow_box_child_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFlowBoxChild`.
   * This should only be used as a child of a `GtkFlowBox`.
   * Returns: a new `GtkFlowBoxChild`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_flow_box_child_new();
    this(_cretval, false);
  }

  /**
   * Marks child as changed, causing any state that depends on this
   * to be updated.
   * This affects sorting and filtering.
   * Note that calls to this method must be in sync with the data
   * used for the sorting and filtering functions. For instance, if
   * the list is mirroring some external data set, and *two* children
   * changed in the external data set when you call
   * [Gtk.FlowBoxChild.changed] on the first child, the sort function
   * must only read the new data for the first of the two changed
   * children, otherwise the resorting of the children will be wrong.
   * This generally means that if you don’t fully control the data
   * model, you have to duplicate the data that affects the sorting
   * and filtering functions into the widgets themselves.
   * Another alternative is to call [Gtk.FlowBox.invalidateSort]
   * on any model change, but that is more expensive.
   */
  void changed()
  {
    gtk_flow_box_child_changed(cast(GtkFlowBoxChild*)cPtr);
  }

  /**
   * Gets the child widget of self.
   * Returns: the child widget of self
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_flow_box_child_get_child(cast(GtkFlowBoxChild*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current index of the child in its `GtkFlowBox` container.
   * Returns: the index of the child, or -1 if the child is not
   *   in a flow box
   */
  int getIndex()
  {
    int _retval;
    _retval = gtk_flow_box_child_get_index(cast(GtkFlowBoxChild*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the child is currently selected in its
   * `GtkFlowBox` container.
   * Returns: %TRUE if child is selected
   */
  bool isSelected()
  {
    bool _retval;
    _retval = gtk_flow_box_child_is_selected(cast(GtkFlowBoxChild*)cPtr);
    return _retval;
  }

  /**
   * Sets the child widget of self.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_flow_box_child_set_child(cast(GtkFlowBoxChild*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Emitted when the user activates a child widget in a `GtkFlowBox`.
   * This can happen either by clicking or double-clicking,
   * or via a keybinding.
   * This is a [keybinding signal](class.SignalAction.html),
   * but it can be used by applications for their own purposes.
   * The default bindings are <kbd>Space</kbd> and <kbd>Enter</kbd>.
   *   flowBoxChild = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(FlowBoxChild flowBoxChild);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto flowBoxChild = getVal!FlowBoxChild(_paramVals);
      _dgClosure.dlg(flowBoxChild);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }
}
