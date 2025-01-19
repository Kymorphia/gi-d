module Gtk.SignalListItemFactory;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.ListItemFactory;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSignalListItemFactory` is a `GtkListItemFactory` that emits signals
 * to manage listitems.
 * Signals are emitted for every listitem in the same order:
 * 1. [Gtk.SignalListItemFactory.setup] is emitted to set up permanent
 * things on the listitem. This usually means constructing the widgets used in
 * the row and adding them to the listitem.
 * 2. [Gtk.SignalListItemFactory.bind] is emitted to bind the item passed
 * via [Gtk.ListItem.item] to the widgets that have been created in
 * step 1 or to add item-specific widgets. Signals are connected to listen to
 * changes - both to changes in the item to update the widgets or to changes
 * in the widgets to update the item. After this signal has been called, the
 * listitem may be shown in a list widget.
 * 3. [Gtk.SignalListItemFactory.unbind] is emitted to undo everything
 * done in step 2. Usually this means disconnecting signal handlers. Once this
 * signal has been called, the listitem will no longer be used in a list
 * widget.
 * 4. [Gtk.SignalListItemFactory.bind] and
 * [Gtk.SignalListItemFactory.unbind] may be emitted multiple times
 * again to bind the listitem for use with new items. By reusing listitems,
 * potentially costly setup can be avoided. However, it means code needs to
 * make sure to properly clean up the listitem in step 3 so that no information
 * from the previous use leaks into the next use.
 * 5. [Gtk.SignalListItemFactory.teardown] is emitted to allow undoing
 * the effects of [Gtk.SignalListItemFactory.setup]. After this signal
 * was emitted on a listitem, the listitem will be destroyed and not be used again.
 * Note that during the signal emissions, changing properties on the
 * listitems passed will not trigger notify signals as the listitem's
 * notifications are frozen. See [GObject.ObjectG.freezeNotify] for details.
 * For tracking changes in other properties in the listitem, the
 * ::notify signal is recommended. The signal can be connected in the
 * [Gtk.SignalListItemFactory.setup] signal and removed again during
 * [Gtk.SignalListItemFactory.teardown].
 */
class SignalListItemFactory : ListItemFactory
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_signal_list_item_factory_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkSignalListItemFactory`.
   * You need to connect signal handlers before you use it.
   * Returns: a new `GtkSignalListItemFactory`
   */
  this()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_signal_list_item_factory_new();
    this(_cretval, true);
  }

  /**
   * Emitted when an object has been bound, for example when a
   * new [Gtk.ListItem.item] has been set on a
   * listitem and should be bound for use.
   * After this signal was emitted, the object might be shown in
   * a [Gtk.ListView] or other widget.
   * The [Gtk.SignalListItemFactory.unbind] signal is the
   * opposite of this signal and can be used to undo everything done
   * in this signal.
   * Params
   *   object = The `GObject` to bind
   *   signalListItemFactory = the instance the signal is connected to
   */
  alias BindCallback = void delegate(ObjectG object, SignalListItemFactory signalListItemFactory);

  /**
   * Connect to Bind signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectBind(BindCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto signalListItemFactory = getVal!SignalListItemFactory(_paramVals);
      auto object = getVal!ObjectG(&_paramVals[1]);
      _dgClosure.dlg(object, signalListItemFactory);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("bind", closure, after);
  }

  /**
   * Emitted when a new listitem has been created and needs to be setup for use.
   * It is the first signal emitted for every listitem.
   * The [Gtk.SignalListItemFactory.teardown] signal is the opposite
   * of this signal and can be used to undo everything done in this signal.
   * Params
   *   object = The `GObject` to set up
   *   signalListItemFactory = the instance the signal is connected to
   */
  alias SetupCallback = void delegate(ObjectG object, SignalListItemFactory signalListItemFactory);

  /**
   * Connect to Setup signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSetup(SetupCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto signalListItemFactory = getVal!SignalListItemFactory(_paramVals);
      auto object = getVal!ObjectG(&_paramVals[1]);
      _dgClosure.dlg(object, signalListItemFactory);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("setup", closure, after);
  }

  /**
   * Emitted when an object is about to be destroyed.
   * It is the last signal ever emitted for this object.
   * This signal is the opposite of the [Gtk.SignalListItemFactory.setup]
   * signal and should be used to undo everything done in that signal.
   * Params
   *   object = The `GObject` to tear down
   *   signalListItemFactory = the instance the signal is connected to
   */
  alias TeardownCallback = void delegate(ObjectG object, SignalListItemFactory signalListItemFactory);

  /**
   * Connect to Teardown signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectTeardown(TeardownCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto signalListItemFactory = getVal!SignalListItemFactory(_paramVals);
      auto object = getVal!ObjectG(&_paramVals[1]);
      _dgClosure.dlg(object, signalListItemFactory);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("teardown", closure, after);
  }

  /**
   * Emitted when an object has been unbound from its item, for example when
   * a listitem was removed from use in a list widget
   * and its [Gtk.ListItem.item] is about to be unset.
   * This signal is the opposite of the [Gtk.SignalListItemFactory.bind]
   * signal and should be used to undo everything done in that signal.
   * Params
   *   object = The `GObject` to unbind
   *   signalListItemFactory = the instance the signal is connected to
   */
  alias UnbindCallback = void delegate(ObjectG object, SignalListItemFactory signalListItemFactory);

  /**
   * Connect to Unbind signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUnbind(UnbindCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto signalListItemFactory = getVal!SignalListItemFactory(_paramVals);
      auto object = getVal!ObjectG(&_paramVals[1]);
      _dgClosure.dlg(object, signalListItemFactory);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unbind", closure, after);
  }
}
