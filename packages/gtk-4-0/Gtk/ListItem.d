module Gtk.ListItem;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkListItem` is used by list widgets to represent items in a
 * [Gio.ListModel].
 * `GtkListItem` objects are managed by the list widget $(LPAREN)with its factory$(RPAREN)
 * and cannot be created by applications, but they need to be populated
 * by application code. This is done by calling [Gtk.ListItem.setChild].
 * `GtkListItem` objects exist in 2 stages:
 * 1. The unbound stage where the listitem is not currently connected to
 * an item in the list. In that case, the [Gtk.ListItem.item]
 * property is set to %NULL.
 * 2. The bound stage where the listitem references an item from the list.
 * The [Gtk.ListItem.item] property is not %NULL.
 */
class ListItem : ObjectG
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
    return gtk_list_item_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the accessible description of self.
   * Returns: the accessible description
   */
  string getAccessibleDescription()
  {
    const(char)* _cretval;
    _cretval = gtk_list_item_get_accessible_description(cast(GtkListItem*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the accessible label of self.
   * Returns: the accessible label
   */
  string getAccessibleLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_list_item_get_accessible_label(cast(GtkListItem*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Checks if a list item has been set to be activatable via
   * [Gtk.ListItem.setActivatable].
   * Returns: %TRUE if the item is activatable
   */
  bool getActivatable()
  {
    bool _retval;
    _retval = gtk_list_item_get_activatable(cast(GtkListItem*)cPtr);
    return _retval;
  }

  /**
   * Gets the child previously set via [Gtk.ListItem.setChild] or
   * %NULL if none was set.
   * Returns: The child
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_list_item_get_child(cast(GtkListItem*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if a list item has been set to be focusable via
   * [Gtk.ListItem.setFocusable].
   * Returns: %TRUE if the item is focusable
   */
  bool getFocusable()
  {
    bool _retval;
    _retval = gtk_list_item_get_focusable(cast(GtkListItem*)cPtr);
    return _retval;
  }

  /**
   * Gets the model item that associated with self.
   * If self is unbound, this function returns %NULL.
   * Returns: The item displayed
   */
  ObjectG getItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_list_item_get_item(cast(GtkListItem*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the position in the model that self currently displays.
   * If self is unbound, %GTK_INVALID_LIST_POSITION is returned.
   * Returns: The position of this item
   */
  uint getPosition()
  {
    uint _retval;
    _retval = gtk_list_item_get_position(cast(GtkListItem*)cPtr);
    return _retval;
  }

  /**
   * Checks if a list item has been set to be selectable via
   * [Gtk.ListItem.setSelectable].
   * Do not confuse this function with [Gtk.ListItem.getSelected].
   * Returns: %TRUE if the item is selectable
   */
  bool getSelectable()
  {
    bool _retval;
    _retval = gtk_list_item_get_selectable(cast(GtkListItem*)cPtr);
    return _retval;
  }

  /**
   * Checks if the item is displayed as selected.
   * The selected state is maintained by the liste widget and its model
   * and cannot be set otherwise.
   * Returns: %TRUE if the item is selected.
   */
  bool getSelected()
  {
    bool _retval;
    _retval = gtk_list_item_get_selected(cast(GtkListItem*)cPtr);
    return _retval;
  }

  /**
   * Sets the accessible description for the list item,
   * which may be used by e.g. screen readers.
   * Params:
   *   description = the description
   */
  void setAccessibleDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    gtk_list_item_set_accessible_description(cast(GtkListItem*)cPtr, _description);
  }

  /**
   * Sets the accessible label for the list item,
   * which may be used by e.g. screen readers.
   * Params:
   *   label = the label
   */
  void setAccessibleLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_list_item_set_accessible_label(cast(GtkListItem*)cPtr, _label);
  }

  /**
   * Sets self to be activatable.
   * If an item is activatable, double-clicking on the item, using
   * the Return key or calling [Gtk.Widget.activate] will activate
   * the item. Activating instructs the containing view to handle
   * activation. `GtkListView` for example will be emitting the
   * [Gtk.ListView.activate] signal.
   * By default, list items are activatable.
   * Params:
   *   activatable = if the item should be activatable
   */
  void setActivatable(bool activatable)
  {
    gtk_list_item_set_activatable(cast(GtkListItem*)cPtr, activatable);
  }

  /**
   * Sets the child to be used for this listitem.
   * This function is typically called by applications when
   * setting up a listitem so that the widget can be reused when
   * binding it multiple times.
   * Params:
   *   child = The list item's child or %NULL to unset
   */
  void setChild(Widget child)
  {
    gtk_list_item_set_child(cast(GtkListItem*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets self to be focusable.
   * If an item is focusable, it can be focused using the keyboard.
   * This works similar to [Gtk.Widget.setFocusable].
   * Note that if items are not focusable, the keyboard cannot be used to activate
   * them and selecting only works if one of the listitem's children is focusable.
   * By default, list items are focusable.
   * Params:
   *   focusable = if the item should be focusable
   */
  void setFocusable(bool focusable)
  {
    gtk_list_item_set_focusable(cast(GtkListItem*)cPtr, focusable);
  }

  /**
   * Sets self to be selectable.
   * If an item is selectable, clicking on the item or using the keyboard
   * will try to select or unselect the item. If this succeeds is up to
   * the model to determine, as it is managing the selected state.
   * Note that this means that making an item non-selectable has no
   * influence on the selected state at all. A non-selectable item
   * may still be selected.
   * By default, list items are selectable. When rebinding them to
   * a new item, they will also be reset to be selectable by GTK.
   * Params:
   *   selectable = if the item should be selectable
   */
  void setSelectable(bool selectable)
  {
    gtk_list_item_set_selectable(cast(GtkListItem*)cPtr, selectable);
  }
}
