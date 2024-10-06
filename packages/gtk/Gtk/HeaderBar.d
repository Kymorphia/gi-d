module Gtk.HeaderBar;

import GObject.ObjectG;
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
 * `GtkHeaderBar` is a widget for creating custom title bars for windows.
 * ![An example GtkHeaderBar](headerbar.png)
 * `GtkHeaderBar` is similar to a horizontal `GtkCenterBox`. It allows
 * children to be placed at the start or the end. In addition, it allows
 * the window title to be displayed. The title will be centered with respect
 * to the width of the box, even if the children at either side take up
 * different amounts of space.
 * `GtkHeaderBar` can add typical window frame controls, such as minimize,
 * maximize and close buttons, or the window icon.
 * For these reasons, `GtkHeaderBar` is the natural choice for use as the
 * custom titlebar widget of a `GtkWindow` $(LPAREN)see [Gtk.Window.setTitlebar]$(RPAREN),
 * as it gives features typical of titlebars while allowing the addition of
 * child widgets.
 * ## GtkHeaderBar as GtkBuildable
 * The `GtkHeaderBar` implementation of the `GtkBuildable` interface supports
 * adding children at the start or end sides by specifying “start” or “end” as
 * the “type” attribute of a `<child>` element, or setting the title widget by
 * specifying “title” value.
 * By default the `GtkHeaderBar` uses a `GtkLabel` displaying the title of the
 * window it is contained in as the title widget, equivalent to the following
 * UI definition:
 * ```xml
 * <object class\="GtkHeaderBar">
 * <property name\="title-widget">
 * <object class\="GtkLabel">
 * <property name\="label" translatable\="yes">Label</property>
 * <property name\="single-line-mode">True</property>
 * <property name\="ellipsize">end</property>
 * <property name\="width-chars">5</property>
 * <style>
 * <class name\="title"/>
 * </style>
 * </object>
 * </property>
 * </object>
 * ```
 * # CSS nodes
 * ```
 * headerbar
 * ╰── windowhandle
 * ╰── box
 * ├── box.start
 * │   ├── windowcontrols.start
 * │   ╰── [other children]
 * ├── [Title Widget]
 * ╰── box.end
 * ├── [other children]
 * ╰── windowcontrols.end
 * ```
 * A `GtkHeaderBar`'s CSS node is called `headerbar`. It contains a `windowhandle`
 * subnode, which contains a `box` subnode, which contains two `box` subnodes at
 * the start and end of the header bar, as well as a center node that represents
 * the title.
 * Each of the boxes contains a `windowcontrols` subnode, see
 * [Gtk.WindowControls] for details, as well as other children.
 * # Accessibility
 * `GtkHeaderBar` uses the %GTK_ACCESSIBLE_ROLE_GROUP role.
 */
class HeaderBar : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_header_bar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkHeaderBar` widget.
   * Returns: a new `GtkHeaderBar`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_header_bar_new();
    this(_cretval, false);
  }

  /**
   * Gets the decoration layout of the `GtkHeaderBar`.
   * Returns: the decoration layout
   */
  string getDecorationLayout()
  {
    const(char)* _cretval;
    _cretval = gtk_header_bar_get_decoration_layout(cast(GtkHeaderBar*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether this header bar shows the standard window
   * title buttons.
   * Returns: %TRUE if title buttons are shown
   */
  bool getShowTitleButtons()
  {
    bool _retval;
    _retval = gtk_header_bar_get_show_title_buttons(cast(GtkHeaderBar*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the title widget of the header.
   * See [Gtk.HeaderBar.setTitleWidget].
   * Returns: the title widget of the header
   */
  Widget getTitleWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_header_bar_get_title_widget(cast(GtkHeaderBar*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds child to bar, packed with reference to the
   * end of the bar.
   * Params:
   *   child = the `GtkWidget` to be added to bar
   */
  void packEnd(Widget child)
  {
    gtk_header_bar_pack_end(cast(GtkHeaderBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Adds child to bar, packed with reference to the
   * start of the bar.
   * Params:
   *   child = the `GtkWidget` to be added to bar
   */
  void packStart(Widget child)
  {
    gtk_header_bar_pack_start(cast(GtkHeaderBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Removes a child from the `GtkHeaderBar`.
   * The child must have been added with
   * [Gtk.HeaderBar.packStart],
   * [Gtk.HeaderBar.packEnd] or
   * [Gtk.HeaderBar.setTitleWidget].
   * Params:
   *   child = the child to remove
   */
  void remove(Widget child)
  {
    gtk_header_bar_remove(cast(GtkHeaderBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the decoration layout for this header bar.
   * This property overrides the
   * propertyGtk.Settings:gtk-decoration-layout setting.
   * There can be valid reasons for overriding the setting, such
   * as a header bar design that does not allow for buttons to take
   * room on the right, or only offers room for a single close button.
   * Split header bars are another example for overriding the setting.
   * The format of the string is button names, separated by commas.
   * A colon separates the buttons that should appear on the left
   * from those on the right. Recognized button names are minimize,
   * maximize, close and icon $(LPAREN)the window icon$(RPAREN).
   * For example, “icon:minimize,maximize,close” specifies an icon
   * on the left, and minimize, maximize and close buttons on the right.
   * Params:
   *   layout = a decoration layout, or %NULL to unset the layout
   */
  void setDecorationLayout(string layout)
  {
    const(char)* _layout = layout.toCString(false);
    gtk_header_bar_set_decoration_layout(cast(GtkHeaderBar*)cPtr, _layout);
  }

  /**
   * Sets whether this header bar shows the standard window
   * title buttons.
   * Params:
   *   setting = %TRUE to show standard title buttons
   */
  void setShowTitleButtons(bool setting)
  {
    gtk_header_bar_set_show_title_buttons(cast(GtkHeaderBar*)cPtr, setting);
  }

  /**
   * Sets the title for the `GtkHeaderBar`.
   * When set to %NULL, the headerbar will display the title of
   * the window it is contained in.
   * The title should help a user identify the current view.
   * To achieve the same style as the builtin title, use the
   * “title” style class.
   * You should set the title widget to %NULL, for the window
   * title label to be visible again.
   * Params:
   *   titleWidget = a widget to use for a title
   */
  void setTitleWidget(Widget titleWidget)
  {
    gtk_header_bar_set_title_widget(cast(GtkHeaderBar*)cPtr, titleWidget ? cast(GtkWidget*)titleWidget.cPtr(false) : null);
  }
}
