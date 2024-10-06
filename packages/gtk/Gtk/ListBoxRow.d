module Gtk.ListBoxRow;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Actionable;
import Gtk.ActionableT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkListBoxRow` is the kind of widget that can be added to a `GtkListBox`.
 */
class ListBoxRow : Widget, Actionable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_list_box_row_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionableT!GtkListBoxRow;

  /**
   * Creates a new `GtkListBoxRow`.
   * Returns: a new `GtkListBoxRow`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_list_box_row_new();
    this(_cretval, false);
  }

  /**
   * Marks row as changed, causing any state that depends on this
   * to be updated.
   * This affects sorting, filtering and headers.
   * Note that calls to this method must be in sync with the data
   * used for the row functions. For instance, if the list is
   * mirroring some external data set, and *two* rows changed in the
   * external data set then when you call [Gtk.ListBoxRow.changed]
   * on the first row the sort function must only read the new data
   * for the first of the two changed rows, otherwise the resorting
   * of the rows will be wrong.
   * This generally means that if you don’t fully control the data
   * model you have to duplicate the data that affects the listbox
   * row functions into the row widgets themselves. Another alternative
   * is to call [Gtk.ListBox.invalidateSort] on any model change,
   * but that is more expensive.
   */
  void changed()
  {
    gtk_list_box_row_changed(cast(GtkListBoxRow*)cPtr);
  }

  /**
   * Gets whether the row is activatable.
   * Returns: %TRUE if the row is activatable
   */
  bool getActivatable()
  {
    bool _retval;
    _retval = gtk_list_box_row_get_activatable(cast(GtkListBoxRow*)cPtr);
    return _retval;
  }

  /**
   * Gets the child widget of row.
   * Returns: the child widget of row
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_list_box_row_get_child(cast(GtkListBoxRow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the current header of the row.
   * This can be used
   * in a [Gtk.ListBoxUpdateHeaderFunc] to see if
   * there is a header set already, and if so to update
   * the state of it.
   * Returns: the current header
   */
  Widget getHeader()
  {
    GtkWidget* _cretval;
    _cretval = gtk_list_box_row_get_header(cast(GtkListBoxRow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current index of the row in its `GtkListBox` container.
   * Returns: the index of the row, or -1 if the row is not in a listbox
   */
  int getIndex()
  {
    int _retval;
    _retval = gtk_list_box_row_get_index(cast(GtkListBoxRow*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the row can be selected.
   * Returns: %TRUE if the row is selectable
   */
  bool getSelectable()
  {
    bool _retval;
    _retval = gtk_list_box_row_get_selectable(cast(GtkListBoxRow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the child is currently selected in its
   * `GtkListBox` container.
   * Returns: %TRUE if row is selected
   */
  bool isSelected()
  {
    bool _retval;
    _retval = gtk_list_box_row_is_selected(cast(GtkListBoxRow*)cPtr);
    return _retval;
  }

  /**
   * Set whether the row is activatable.
   * Params:
   *   activatable = %TRUE to mark the row as activatable
   */
  void setActivatable(bool activatable)
  {
    gtk_list_box_row_set_activatable(cast(GtkListBoxRow*)cPtr, activatable);
  }

  /**
   * Sets the child widget of self.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_list_box_row_set_child(cast(GtkListBoxRow*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the current header of the row.
   * This is only allowed to be called
   * from a [Gtk.ListBoxUpdateHeaderFunc].
   * It will replace any existing header in the row,
   * and be shown in front of the row in the listbox.
   * Params:
   *   header = the header
   */
  void setHeader(Widget header)
  {
    gtk_list_box_row_set_header(cast(GtkListBoxRow*)cPtr, header ? cast(GtkWidget*)header.cPtr(false) : null);
  }

  /**
   * Set whether the row can be selected.
   * Params:
   *   selectable = %TRUE to mark the row as selectable
   */
  void setSelectable(bool selectable)
  {
    gtk_list_box_row_set_selectable(cast(GtkListBoxRow*)cPtr, selectable);
  }

  /**
   * This is a keybinding signal, which will cause this row to be activated.
   * If you want to be notified when the user activates a row $(LPAREN)by key or not$(RPAREN),
   * use the signalGtk.ListBox::row-activated signal on the row’s parent
   * `GtkListBox`.
   *   listBoxRow = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(ListBoxRow listBoxRow);

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
      auto listBoxRow = getVal!ListBoxRow(_paramVals);
      _dgClosure.dlg(listBoxRow);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }
}
