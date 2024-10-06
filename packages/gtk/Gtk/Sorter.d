module Gtk.Sorter;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSorter` is an object to describe sorting criteria.
 * Its primary user is [Gtk.SortListModel]
 * The model will use a sorter to determine the order in which
 * its items should appear by calling [Gtk.Sorter.compare]
 * for pairs of items.
 * Sorters may change their sorting behavior through their lifetime.
 * In that case, they will emit the [Gtk.Sorter.changed] signal
 * to notify that the sort order is no longer valid and should be updated
 * by calling [Gtk.Sorter.compare] again.
 * GTK provides various pre-made sorter implementations for common sorting
 * operations. [Gtk.ColumnView] has built-in support for sorting lists
 * via the [Gtk.ColumnViewColumn.sorter] property, where the user can
 * change the sorting by clicking on list headers.
 * Of course, in particular for large lists, it is also possible to subclass
 * `GtkSorter` and provide one's own sorter.
 */
class Sorter : ObjectG
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
    return gtk_sorter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Notifies all users of the sorter that it has changed.
   * This emits the [Gtk.Sorter.changed] signal. Users
   * of the sorter should then update the sort order via
   * [Gtk.Sorter.compare].
   * Depending on the change parameter, it may be possible to
   * update the sort order without a full resorting. Refer to
   * the [Gtk] documentation for details.
   * This function is intended for implementers of `GtkSorter`
   * subclasses and should not be called from other functions.
   * Params:
   *   change = How the sorter changed
   */
  void changed(SorterChange change)
  {
    gtk_sorter_changed(cast(GtkSorter*)cPtr, change);
  }

  /**
   * Compares two given items according to the sort order implemented
   * by the sorter.
   * Sorters implement a partial order:
   * * It is reflexive, ie a \= a
   * * It is antisymmetric, ie if a < b and b < a, then a \= b
   * * It is transitive, ie given any 3 items with a ≤ b and b ≤ c,
   * then a ≤ c
   * The sorter may signal it conforms to additional constraints
   * via the return value of [Gtk.Sorter.getOrder].
   * Params:
   *   item1 = first item to compare
   *   item2 = second item to compare
   * Returns: %GTK_ORDERING_EQUAL if item1 \=\= item2,
   *   %GTK_ORDERING_SMALLER if item1 < item2,
   *   %GTK_ORDERING_LARGER if item1 > item2
   */
  Ordering compare(ObjectG item1, ObjectG item2)
  {
    GtkOrdering _cretval;
    _cretval = gtk_sorter_compare(cast(GtkSorter*)cPtr, item1 ? cast(ObjectC*)item1.cPtr(false) : null, item2 ? cast(ObjectC*)item2.cPtr(false) : null);
    Ordering _retval = cast(Ordering)_cretval;
    return _retval;
  }

  /**
   * Gets the order that self conforms to.
   * See [Gtk] for details
   * of the possible return values.
   * This function is intended to allow optimizations.
   * Returns: The order
   */
  SorterOrder getOrder()
  {
    GtkSorterOrder _cretval;
    _cretval = gtk_sorter_get_order(cast(GtkSorter*)cPtr);
    SorterOrder _retval = cast(SorterOrder)_cretval;
    return _retval;
  }

  /**
   * Emitted whenever the sorter changed.
   * Users of the sorter should then update the sort order
   * again via [Gtk.Sorter.compare].
   * [Gtk.SortListModel] handles this signal automatically.
   * Depending on the change parameter, it may be possible to update
   * the sort order without a full resorting. Refer to the
   * [Gtk] documentation for details.
   * Params
   *   change = how the sorter changed
   *   sorter = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(SorterChange change, Sorter sorter);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto sorter = getVal!Sorter(_paramVals);
      auto change = getVal!SorterChange(&_paramVals[1]);
      _dgClosure.dlg(change, sorter);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }
}
