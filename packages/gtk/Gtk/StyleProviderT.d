module Gtk.StyleProviderT;

public import GObject.DClosure;
public import GObject.Types;
public import Gid.gid;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * `GtkStyleProvider` is an interface for style information used by
 * `GtkStyleContext`.
 * See [Gtk.StyleContext.addProvider] and
 * [Gtk.StyleContext.addProviderForDisplay] for
 * adding `GtkStyleProviders`.
 * GTK uses the `GtkStyleProvider` implementation for CSS in
 * [Gtk.CssProvider].
 */
template StyleProviderT(TStruct)
{

  alias GtkPrivateChangedCallback = void delegate(StyleProvider styleProvider);

  /**
   * Connect to GtkPrivateChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectGtkPrivateChanged(GtkPrivateChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto styleProvider = getVal!StyleProvider(_paramVals);
      _dgClosure.dlg(styleProvider);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("gtk-private-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}
