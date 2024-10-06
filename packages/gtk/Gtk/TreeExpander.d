module Gtk.TreeExpander;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.TreeListRow;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkTreeExpander` is a widget that provides an expander for a list.
 * It is typically placed as a bottommost child into a `GtkListView`
 * to allow users to expand and collapse children in a list with a
 * [Gtk.TreeListModel]. `GtkTreeExpander` provides the common UI
 * elements, gestures and keybindings for this purpose.
 * On top of this, the "listitem.expand", "listitem.collapse" and
 * "listitem.toggle-expand" actions are provided to allow adding custom
 * UI for managing expanded state.
 * It is important to mention that you want to set the
 * [Gtk.ListItem.focusable] property to FALSE when using this
 * widget, as you want the keyboard focus to be in the treexpander, and not
 * inside the list to make use of the keybindings.
 * The `GtkTreeListModel` must be set to not be passthrough. Then it
 * will provide [Gtk.TreeListRow] items which can be set via
 * [Gtk.TreeExpander.setListRow] on the expander.
 * The expander will then watch that row item automatically.
 * [Gtk.TreeExpander.setChild] sets the widget that displays
 * the actual row contents.
 * `GtkTreeExpander` can be modified with properties such as
 * property@Gtk.TreeExpander:indent-for-icon,
 * property@Gtk.TreeExpander:indent-for-depth, and
 * property@Gtk.TreeExpander:hide-expander to achieve a different appearance.
 * This can even be done to influence individual rows, for example by binding
 * the property@Gtk.TreeExpander:hide-expander property to the item count of
 * the model of the treelistrow, to hide the expander for rows without children,
 * even if the row is expandable.
 * ## CSS nodes
 * ```
 * treeexpander
 * ├── [indent]*
 * ├── [expander]
 * ╰── <child>
 * ```
 * `GtkTreeExpander` has zero or one CSS nodes with the name "expander" that
 * should display the expander icon. The node will be `:checked` when it
 * is expanded. If the node is not expandable, an "indent" node will be
 * displayed instead.
 * For every level of depth, another "indent" node is prepended.
 * ## Accessibility
 * Until GTK 4.10, `GtkTreeExpander` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 * Since GTK 4.12, `GtkTreeExpander` uses the `GTK_ACCESSIBLE_ROLE_BUTTON` role.
 * Toggling it will change the `GTK_ACCESSIBLE_STATE_EXPANDED` state.
 */
class TreeExpander : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_tree_expander_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkTreeExpander`
   * Returns: a new `GtkTreeExpander`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_expander_new();
    this(_cretval, false);
  }

  /**
   * Gets the child widget displayed by self.
   * Returns: The child displayed by self
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_expander_get_child(cast(GtkTreeExpander*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the TreeExpander should be hidden in a GtkTreeListRow.
   * Returns: TRUE if the expander icon should be hidden. Otherwise FALSE.
   */
  bool getHideExpander()
  {
    bool _retval;
    _retval = gtk_tree_expander_get_hide_expander(cast(GtkTreeExpander*)cPtr);
    return _retval;
  }

  /**
   * TreeExpander indents each level of depth with an additional indent.
   * Returns: TRUE if the child should be indented . Otherwise FALSE.
   */
  bool getIndentForDepth()
  {
    bool _retval;
    _retval = gtk_tree_expander_get_indent_for_depth(cast(GtkTreeExpander*)cPtr);
    return _retval;
  }

  /**
   * TreeExpander indents the child by the width of an expander-icon if it is not expandable.
   * Returns: TRUE if the child should be indented when not expandable. Otherwise FALSE.
   */
  bool getIndentForIcon()
  {
    bool _retval;
    _retval = gtk_tree_expander_get_indent_for_icon(cast(GtkTreeExpander*)cPtr);
    return _retval;
  }

  /**
   * Forwards the item set on the `GtkTreeListRow` that self is managing.
   * This call is essentially equivalent to calling:
   * ```c
   * gtk_tree_list_row_get_item $(LPAREN)gtk_tree_expander_get_list_row $(LPAREN)self$(RPAREN)$(RPAREN);
   * ```
   * Returns: The item of the row
   */
  ObjectG getItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_tree_expander_get_item(cast(GtkTreeExpander*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the list row managed by self.
   * Returns: The list row displayed by self
   */
  TreeListRow getListRow()
  {
    GtkTreeListRow* _cretval;
    _cretval = gtk_tree_expander_get_list_row(cast(GtkTreeExpander*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeListRow(cast(GtkTreeListRow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the content widget to display.
   * Params:
   *   child = a `GtkWidget`
   */
  void setChild(Widget child)
  {
    gtk_tree_expander_set_child(cast(GtkTreeExpander*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether the expander icon should be visible in a GtkTreeListRow.
   * Params:
   *   hideExpander = TRUE if the expander should be hidden. Otherwise FALSE.
   */
  void setHideExpander(bool hideExpander)
  {
    gtk_tree_expander_set_hide_expander(cast(GtkTreeExpander*)cPtr, hideExpander);
  }

  /**
   * Sets if the TreeExpander should indent the child according to its depth.
   * Params:
   *   indentForDepth = TRUE if the child should be indented. Otherwise FALSE.
   */
  void setIndentForDepth(bool indentForDepth)
  {
    gtk_tree_expander_set_indent_for_depth(cast(GtkTreeExpander*)cPtr, indentForDepth);
  }

  /**
   * Sets if the TreeExpander should indent the child by the width of an expander-icon when it is not expandable.
   * Params:
   *   indentForIcon = TRUE if the child should be indented without expander. Otherwise FALSE.
   */
  void setIndentForIcon(bool indentForIcon)
  {
    gtk_tree_expander_set_indent_for_icon(cast(GtkTreeExpander*)cPtr, indentForIcon);
  }

  /**
   * Sets the tree list row that this expander should manage.
   * Params:
   *   listRow = a `GtkTreeListRow`
   */
  void setListRow(TreeListRow listRow)
  {
    gtk_tree_expander_set_list_row(cast(GtkTreeExpander*)cPtr, listRow ? cast(GtkTreeListRow*)listRow.cPtr(false) : null);
  }
}
