module Gtk.Filter;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkFilter` object describes the filtering to be performed by a
 * [Gtk.FilterListModel].
 * The model will use the filter to determine if it should include items
 * or not by calling [Gtk.Filter.match] for each item and only
 * keeping the ones that the function returns %TRUE for.
 * Filters may change what items they match through their lifetime. In that
 * case, they will emit the [Gtk.Filter.changed] signal to notify
 * that previous filter results are no longer valid and that items should
 * be checked again via [Gtk.Filter.match].
 * GTK provides various pre-made filter implementations for common filtering
 * operations. These filters often include properties that can be linked to
 * various widgets to easily allow searches.
 * However, in particular for large lists or complex search methods, it is
 * also possible to subclass `GtkFilter` and provide one's own filter.
 */
class Filter : ObjectG
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
    return gtk_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Notifies all users of the filter that it has changed.
   * This emits the [Gtk.Filter.changed] signal. Users
   * of the filter should then check items again via
   * [Gtk.Filter.match].
   * Depending on the change parameter, not all items need to
   * be changed, but only some. Refer to the [Gtk]
   * documentation for details.
   * This function is intended for implementers of `GtkFilter`
   * subclasses and should not be called from other functions.
   * Params:
   *   change = How the filter changed
   */
  void changed(FilterChange change)
  {
    gtk_filter_changed(cast(GtkFilter*)cPtr, change);
  }

  /**
   * Gets the known strictness of filters.
   * If the strictness is not known, %GTK_FILTER_MATCH_SOME is returned.
   * This value may change after emission of the [Gtk.Filter.changed]
   * signal.
   * This function is meant purely for optimization purposes, filters can
   * choose to omit implementing it, but `GtkFilterListModel` uses it.
   * Returns: the strictness of self
   */
  FilterMatch getStrictness()
  {
    GtkFilterMatch _cretval;
    _cretval = gtk_filter_get_strictness(cast(GtkFilter*)cPtr);
    FilterMatch _retval = cast(FilterMatch)_cretval;
    return _retval;
  }

  /**
   * Checks if the given item is matched by the filter or not.
   * Params:
   *   item = The item to check
   * Returns: %TRUE if the filter matches the item and a filter model should
   *   keep it, %FALSE if not.
   */
  bool match(ObjectG item)
  {
    bool _retval;
    _retval = gtk_filter_match(cast(GtkFilter*)cPtr, item ? cast(ObjectC*)item.cPtr(false) : null);
    return _retval;
  }

  /**
   * Emitted whenever the filter changed.
   * Users of the filter should then check items again via
   * [Gtk.Filter.match].
   * `GtkFilterListModel` handles this signal automatically.
   * Depending on the change parameter, not all items need
   * to be checked, but only some. Refer to the [Gtk]
   * documentation for details.
   * Params
   *   change = how the filter changed
   *   filter = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(FilterChange change, Filter filter);

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
      auto filter = getVal!Filter(_paramVals);
      auto change = getVal!FilterChange(&_paramVals[1]);
      _dgClosure.dlg(change, filter);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }
}
