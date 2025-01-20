module Gtk.SearchBar;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Editable;
import Gtk.EditableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSearchBar` is a container made to have a search entry.
 * ![An example GtkSearchBar](search-bar.png)
 * It can also contain additional widgets, such as drop-down menus,
 * or buttons.  The search bar would appear when a search is started
 * through typing on the keyboard, or the application’s search mode
 * is toggled on.
 * For keyboard presses to start a search, the search bar must be told
 * of a widget to capture key events from through
 * [Gtk.SearchBar.setKeyCaptureWidget]. This widget will
 * typically be the top-level window, or a parent container of the
 * search bar. Common shortcuts such as Ctrl+F should be handled as an
 * application action, or through the menu items.
 * You will also need to tell the search bar about which entry you
 * are using as your search entry using [Gtk.SearchBar.connectEntry].
 * ## Creating a search bar
 * The following example shows you how to create a more complex search
 * entry.
 * [A simple example](https://gitlab.gnome.org/GNOME/gtk/tree/main/examples/search-bar.c)
 * # CSS nodes
 * ```
 * searchbar
 * ╰── revealer
 * ╰── box
 * ├── [child]
 * ╰── [button.close]
 * ```
 * `GtkSearchBar` has a main CSS node with name searchbar. It has a child
 * node with name revealer that contains a node with name box. The box node
 * contains both the CSS node of the child widget as well as an optional button
 * node which gets the .close style class applied.
 * # Accessibility
 * `GtkSearchBar` uses the %GTK_ACCESSIBLE_ROLE_SEARCH role.
 */
class SearchBar : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_search_bar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkSearchBar`.
   * You will need to tell it about which widget is going to be your text
   * entry using [Gtk.SearchBar.connectEntry].
   * Returns: a new `GtkSearchBar`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_search_bar_new();
    this(_cretval, false);
  }

  /**
   * Connects the `GtkEditable` widget passed as the one to be used in
   * this search bar.
   * The entry should be a descendant of the search bar. Calling this
   * function manually is only required if the entry isn’t the direct
   * child of the search bar $(LPAREN)as in our main example$(RPAREN).
   * Params:
   *   entry = a `GtkEditable`
   */
  void connectEntry(Editable entry)
  {
    gtk_search_bar_connect_entry(cast(GtkSearchBar*)cPtr, entry ? cast(GtkEditable*)(cast(ObjectG)entry).cPtr(false) : null);
  }

  /**
   * Gets the child widget of bar.
   * Returns: the child widget of bar
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_search_bar_get_child(cast(GtkSearchBar*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the widget that bar is capturing key events from.
   * Returns: The key capture widget.
   */
  Widget getKeyCaptureWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_search_bar_get_key_capture_widget(cast(GtkSearchBar*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the search mode is on or off.
   * Returns: whether search mode is toggled on
   */
  bool getSearchMode()
  {
    bool _retval;
    _retval = gtk_search_bar_get_search_mode(cast(GtkSearchBar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the close button is shown.
   * Returns: whether the close button is shown
   */
  bool getShowCloseButton()
  {
    bool _retval;
    _retval = gtk_search_bar_get_show_close_button(cast(GtkSearchBar*)cPtr);
    return _retval;
  }

  /**
   * Sets the child widget of bar.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_search_bar_set_child(cast(GtkSearchBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets widget as the widget that bar will capture key events
   * from.
   * If key events are handled by the search bar, the bar will
   * be shown, and the entry populated with the entered text.
   * Note that despite the name of this function, the events
   * are only 'captured' in the bubble phase, which means that
   * editable child widgets of widget will receive text input
   * before it gets captured. If that is not desired, you can
   * capture and forward the events yourself with
   * [Gtk.EventControllerKey.forward].
   * Params:
   *   widget = a `GtkWidget`
   */
  void setKeyCaptureWidget(Widget widget)
  {
    gtk_search_bar_set_key_capture_widget(cast(GtkSearchBar*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Switches the search mode on or off.
   * Params:
   *   searchMode = the new state of the search mode
   */
  void setSearchMode(bool searchMode)
  {
    gtk_search_bar_set_search_mode(cast(GtkSearchBar*)cPtr, searchMode);
  }

  /**
   * Shows or hides the close button.
   * Applications that already have a “search” toggle button should not
   * show a close button in their search bar, as it duplicates the role
   * of the toggle button.
   * Params:
   *   visible = whether the close button will be shown or not
   */
  void setShowCloseButton(bool visible)
  {
    gtk_search_bar_set_show_close_button(cast(GtkSearchBar*)cPtr, visible);
  }
}
