module Gtk.IconTheme;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gdk.Display;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gtk.IconPaintable;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkIconTheme` provides a facility for loading themed icons.
 * The main reason for using a name rather than simply providing a filename
 * is to allow different icons to be used depending on what “icon theme” is
 * selected by the user. The operation of icon themes on Linux and Unix
 * follows the [Icon Theme Specification](http://www.freedesktop.org/Standards/icon-theme-spec)
 * There is a fallback icon theme, named `hicolor`, where applications
 * should install their icons, but additional icon themes can be installed
 * as operating system vendors and users choose.
 * In many cases, named themes are used indirectly, via [Gtk.Image]
 * rather than directly, but looking up icons directly is also simple. The
 * `GtkIconTheme` object acts as a database of all the icons in the current
 * theme. You can create new `GtkIconTheme` objects, but it’s much more
 * efficient to use the standard icon theme of the `GtkWidget` so that the
 * icon information is shared with other people looking up icons.
 * ```c
 * GtkIconTheme *icon_theme;
 * GtkIconPaintable *icon;
 * GdkPaintable *paintable;
 * icon_theme \= gtk_icon_theme_get_for_display $(LPAREN)gtk_widget_get_display $(LPAREN)my_widget$(RPAREN)$(RPAREN);
 * icon \= gtk_icon_theme_lookup_icon $(LPAREN)icon_theme,
 * "my-icon-name", // icon name
 * 48, // icon size
 * 1,  // scale
 * 0,  // flags$(RPAREN);
 * paintable \= GDK_PAINTABLE $(LPAREN)icon$(RPAREN);
 * // Use the paintable
 * g_object_unref $(LPAREN)icon$(RPAREN);
 * ```
 */
class IconTheme : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_icon_theme_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new icon theme object.
   * Icon theme objects are used to lookup up an icon by name
   * in a particular icon theme. Usually, you’ll want to use
   * [Gtk.IconTheme.getForDisplay] rather than creating
   * a new icon theme object for scratch.
   * Returns: the newly created `GtkIconTheme` object.
   */
  this()
  {
    GtkIconTheme* _cretval;
    _cretval = gtk_icon_theme_new();
    this(_cretval, true);
  }

  /**
   * Gets the icon theme object associated with display.
   * If this function has not previously been called for the given
   * display, a new icon theme object will be created and associated
   * with the display. Icon theme objects are fairly expensive to create,
   * so using this function is usually a better choice than calling
   * [Gtk.IconTheme.new_] and setting the display yourself; by using
   * this function a single icon theme object will be shared between users.
   * Params:
   *   display = a `GdkDisplay`
   * Returns: A unique `GtkIconTheme` associated with
   *   the given display. This icon theme is associated with the display
   *   and can be used as long as the display is open. Do not ref or unref it.
   */
  static IconTheme getForDisplay(Display display)
  {
    GtkIconTheme* _cretval;
    _cretval = gtk_icon_theme_get_for_display(display ? cast(GdkDisplay*)display.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!IconTheme(cast(GtkIconTheme*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a resource path that will be looked at when looking
   * for icons, similar to search paths.
   * See [Gtk.IconTheme.setResourcePath].
   * This function should be used to make application-specific icons
   * available as part of the icon theme.
   * Params:
   *   path = a resource path
   */
  void addResourcePath(string path)
  {
    const(char)* _path = path.toCString(false);
    gtk_icon_theme_add_resource_path(cast(GtkIconTheme*)cPtr, _path);
  }

  /**
   * Appends a directory to the search path.
   * See [Gtk.IconTheme.setSearchPath].
   * Params:
   *   path = directory name to append to the icon path
   */
  void addSearchPath(string path)
  {
    const(char)* _path = path.toCString(false);
    gtk_icon_theme_add_search_path(cast(GtkIconTheme*)cPtr, _path);
  }

  /**
   * Returns the display that the `GtkIconTheme` object was
   * created for.
   * Returns: the display of icon_theme
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gtk_icon_theme_get_display(cast(GtkIconTheme*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current icon theme name.
   * Returns $(LPAREN)transfer full$(RPAREN): the current icon theme name,
   * Returns:
   */
  string getThemeName()
  {
    char* _cretval;
    _cretval = gtk_icon_theme_get_theme_name(cast(GtkIconTheme*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Checks whether an icon theme includes an icon
   * for a particular `GIcon`.
   * Params:
   *   gicon = a `GIcon`
   * Returns: %TRUE if self includes an icon for gicon
   */
  bool hasGicon(Icon gicon)
  {
    bool _retval;
    _retval = gtk_icon_theme_has_gicon(cast(GtkIconTheme*)cPtr, gicon ? cast(GIcon*)(cast(ObjectG)gicon).cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether an icon theme includes an icon
   * for a particular name.
   * Params:
   *   iconName = the name of an icon
   * Returns: %TRUE if self includes an
   *   icon for icon_name.
   */
  bool hasIcon(string iconName)
  {
    bool _retval;
    const(char)* _iconName = iconName.toCString(false);
    _retval = gtk_icon_theme_has_icon(cast(GtkIconTheme*)cPtr, _iconName);
    return _retval;
  }

  /**
   * Looks up a icon for a desired size and window scale.
   * The icon can then be rendered by using it as a `GdkPaintable`,
   * or you can get information such as the filename and size.
   * Params:
   *   icon = the `GIcon` to look up
   *   size = desired icon size
   *   scale = the desired scale
   *   direction = text direction the icon will be displayed in
   *   flags = flags modifying the behavior of the icon lookup
   * Returns: a `GtkIconPaintable` containing
   *   information about the icon. Unref with [GObject.ObjectG.unref]
   */
  IconPaintable lookupByGicon(Icon icon, int size, int scale, TextDirection direction, IconLookupFlags flags)
  {
    GtkIconPaintable* _cretval;
    _cretval = gtk_icon_theme_lookup_by_gicon(cast(GtkIconTheme*)cPtr, icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null, size, scale, direction, flags);
    auto _retval = _cretval ? ObjectG.getDObject!IconPaintable(cast(GtkIconPaintable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets the name of the icon theme that the `GtkIconTheme` object uses
   * overriding system configuration.
   * This function cannot be called on the icon theme objects returned
   * from [Gtk.IconTheme.getForDisplay].
   * Params:
   *   themeName = name of icon theme to use instead of
   *     configured theme, or %NULL to unset a previously set custom theme
   */
  void setThemeName(string themeName)
  {
    const(char)* _themeName = themeName.toCString(false);
    gtk_icon_theme_set_theme_name(cast(GtkIconTheme*)cPtr, _themeName);
  }

  /**
   * Emitted when the icon theme changes.
   * This can happen because current icon theme is switched or
   * because GTK detects that a change has occurred in the
   * contents of the current icon theme.
   *   iconTheme = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(IconTheme iconTheme);

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
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iconTheme = getVal!IconTheme(_paramVals);
      _dgClosure.dlg(iconTheme);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }
}
