module Gtk.ShortcutsWindow;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.ShortcutsSection;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutsWindow` shows information about the keyboard shortcuts
 * and gestures of an application.
 * The shortcuts can be grouped, and you can have multiple sections in this
 * window, corresponding to the major modes of your application.
 * Additionally, the shortcuts can be filtered by the current view, to avoid
 * showing information that is not relevant in the current application context.
 * The recommended way to construct a `GtkShortcutsWindow` is with
 * [Gtk.Builder], by using the `<child>` tag to populate a
 * `GtkShortcutsWindow` with one or more [Gtk.ShortcutsSection] objects,
 * which contain one or more [Gtk.ShortcutsGroup] instances, which, in turn,
 * contain [Gtk.ShortcutsShortcut] instances.
 * If you need to add a section programmatically, use [Gtk.ShortcutsWindow.addSection]
 * instead of [Gtk.Window.setChild], as the shortcuts window manages
 * its children directly.
 * # A simple example:
 * ![](gedit-shortcuts.png)
 * This example has as single section. As you can see, the shortcut groups
 * are arranged in columns, and spread across several pages if there are too
 * many to find on a single page.
 * The .ui file for this example can be found [here](https://gitlab.gnome.org/GNOME/gtk/tree/main/demos/gtk-demo/shortcuts-gedit.ui).
 * # An example with multiple views:
 * ![](clocks-shortcuts.png)
 * This example shows a `GtkShortcutsWindow` that has been configured to show only
 * the shortcuts relevant to the "stopwatch" view.
 * The .ui file for this example can be found [here](https://gitlab.gnome.org/GNOME/gtk/tree/main/demos/gtk-demo/shortcuts-clocks.ui).
 * # An example with multiple sections:
 * ![](builder-shortcuts.png)
 * This example shows a `GtkShortcutsWindow` with two sections, "Editor Shortcuts"
 * and "Terminal Shortcuts".
 * The .ui file for this example can be found [here](https://gitlab.gnome.org/GNOME/gtk/tree/main/demos/gtk-demo/shortcuts-builder.ui).
 * ## CSS nodes
 * `GtkShortcutsWindow` has a single CSS node with the name `window` and style
 * class `.shortcuts`.
 */
class ShortcutsWindow : Window
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
    return gtk_shortcuts_window_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Adds a section to the shortcuts window.
   * This is the programmatic equivalent to using [Gtk.Builder] and a
   * `<child>` tag to add the child.
   * Using [Gtk.Window.setChild] is not appropriate as the shortcuts
   * window manages its children internally.
   * Params:
   *   section = the `GtkShortcutsSection` to add
   */
  void addSection(ShortcutsSection section)
  {
    gtk_shortcuts_window_add_section(cast(GtkShortcutsWindow*)cPtr, section ? cast(GtkShortcutsSection*)section.cPtr(false) : null);
  }

  /**
   * Emitted when the user uses a keybinding to close the window.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is the Escape key.
   *   shortcutsWindow = the instance the signal is connected to
   */
  alias CloseCallback = void delegate(ShortcutsWindow shortcutsWindow);

  /**
   * Connect to Close signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectClose(CloseCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto shortcutsWindow = getVal!ShortcutsWindow(_paramVals);
      _dgClosure.dlg(shortcutsWindow);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("close", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user uses a keybinding to start a search.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is Control-F.
   *   shortcutsWindow = the instance the signal is connected to
   */
  alias SearchCallback = void delegate(ShortcutsWindow shortcutsWindow);

  /**
   * Connect to Search signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectSearch(SearchCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto shortcutsWindow = getVal!ShortcutsWindow(_paramVals);
      _dgClosure.dlg(shortcutsWindow);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("search", closure, (flags & ConnectFlags.After) != 0);
  }
}
