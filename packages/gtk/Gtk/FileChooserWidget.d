module Gtk.FileChooserWidget;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.FileChooser;
import Gtk.FileChooserT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFileChooserWidget` is a widget for choosing files.
 * It exposes the [Gtk.FileChooser] interface, and you should
 * use the methods of this interface to interact with the
 * widget.
 * # CSS nodes
 * `GtkFileChooserWidget` has a single CSS node with name filechooser.

 * Deprecated: Direct use of `GtkFileChooserWidget` is deprecated
 */
class FileChooserWidget : Widget, FileChooser
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
    return gtk_file_chooser_widget_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin FileChooserT!GtkFileChooserWidget;

  /**
   * Creates a new `GtkFileChooserWidget`.
   * This is a file chooser widget that can be embedded in custom
   * windows, and it is the same widget that is used by
   * `GtkFileChooserDialog`.
   * Params:
   *   action = Open or save mode for the widget
   * Returns: a new `GtkFileChooserWidget`

   * Deprecated: Direct use of `GtkFileChooserWidget` is deprecated
   */
  this(FileChooserAction action)
  {
    GtkWidget* _cretval;
    _cretval = gtk_file_chooser_widget_new(action);
    this(_cretval, false);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser show the user's Desktop
   * folder in the file list.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>D</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias DesktopFolderCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to DesktopFolder signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDesktopFolder(DesktopFolderCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("desktop-folder", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser go to a child of the
   * current folder in the file hierarchy. The subfolder that will
   * be used is displayed in the path bar widget of the file chooser.
   * For example, if the path bar is showing "/foo/bar/baz", with bar
   * currently displayed, then this will cause the file chooser to
   * switch to the "baz" subfolder.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>Down</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias DownFolderCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to DownFolder signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDownFolder(DownFolderCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("down-folder", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser show the user's home
   * folder in the file list.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>Home</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias HomeFolderCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to HomeFolder signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectHomeFolder(HomeFolderCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("home-folder", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser show a "Location" prompt which
   * the user can use to manually type the name of the file he wishes to select.
   * The default bindings for this signal are <kbd>Control</kbd>-<kbd>L</kbd>
   * with a path string of "" $(LPAREN)the empty string$(RPAREN). It is also bound to
   * <kbd>/</kbd> with a path string of "`/`" $(LPAREN)a slash$(RPAREN):  this lets you
   * type `/` and immediately type a path name. On Unix systems, this is
   * bound to <kbd>~</kbd> $(LPAREN)tilde$(RPAREN) with a path string of "~" itself for
   * access to home directories.
   * Params
   *   path = a string that gets put in the text entry for the file name
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias LocationPopupCallback = void delegate(string path, FileChooserWidget fileChooserWidget);

  /**
   * Connect to LocationPopup signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectLocationPopup(LocationPopupCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      auto path = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(path, fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("location-popup", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser show a "Location" prompt
   * when the user pastes into a `GtkFileChooserWidget`.
   * The default binding for this signal is <kbd>Control</kbd>-<kbd>V</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias LocationPopupOnPasteCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to LocationPopupOnPaste signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectLocationPopupOnPaste(LocationPopupOnPasteCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("location-popup-on-paste", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to toggle the visibility of a "Location" prompt
   * which the user can use to manually type the name of the file
   * he wishes to select.
   * The default binding for this signal is <kbd>Control</kbd>-<kbd>L</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias LocationTogglePopupCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to LocationTogglePopup signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectLocationTogglePopup(LocationTogglePopupCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("location-toggle-popup", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to move the focus to the places sidebar.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>P</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias PlacesShortcutCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to PlacesShortcut signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPlacesShortcut(PlacesShortcutCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("places-shortcut", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser switch to the bookmark
   * specified in the bookmark_index parameter. For example, if
   * you have three bookmarks, you can pass 0, 1, 2 to this signal
   * to switch to each of them, respectively.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>1</kbd>,
   * <kbd>Alt</kbd>-<kbd>2</kbd>, etc. until <kbd>Alt</kbd>-<kbd>0</kbd>.
   * Note that in the default binding, that <kbd>Alt</kbd>-<kbd>1</kbd> is
   * actually defined to switch to the bookmark at index 0, and so on
   * successively.
   * Params
   *   bookmarkIndex = the number of the bookmark to switch to
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias QuickBookmarkCallback = void delegate(int bookmarkIndex, FileChooserWidget fileChooserWidget);

  /**
   * Connect to QuickBookmark signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectQuickBookmark(QuickBookmarkCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      auto bookmarkIndex = getVal!int(&_paramVals[1]);
      _dgClosure.dlg(bookmarkIndex, fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("quick-bookmark", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser show the Recent location.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>R</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias RecentShortcutCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to RecentShortcut signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectRecentShortcut(RecentShortcutCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("recent-shortcut", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser show the search entry.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>S</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias SearchShortcutCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to SearchShortcut signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectSearchShortcut(SearchShortcutCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("search-shortcut", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser display hidden files.
   * The default binding for this signal is <kbd>Control</kbd>-<kbd>H</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias ShowHiddenCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to ShowHidden signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectShowHidden(ShowHiddenCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("show-hidden", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * This is used to make the file chooser go to the parent
   * of the current folder in the file hierarchy.
   * The default binding for this signal is <kbd>Alt</kbd>-<kbd>Up</kbd>.
   *   fileChooserWidget = the instance the signal is connected to
   */
  alias UpFolderCallback = void delegate(FileChooserWidget fileChooserWidget);

  /**
   * Connect to UpFolder signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectUpFolder(UpFolderCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileChooserWidget = getVal!FileChooserWidget(_paramVals);
      _dgClosure.dlg(fileChooserWidget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("up-folder", closure, (flags & ConnectFlags.After) != 0);
  }
}
