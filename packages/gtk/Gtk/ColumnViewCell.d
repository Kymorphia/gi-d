module Gtk.ColumnViewCell;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ListItem;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkColumnViewCell` is used by [Gtk.ColumnViewColumn] to represent items
 * in a cell in [Gtk.ColumnView].
 * The `GtkColumnViewCell`s are managed by the columnview widget $(LPAREN)with its factory$(RPAREN)
 * and cannot be created by applications, but they need to be populated
 * by application code. This is done by calling [Gtk.ColumnViewCell.setChild].
 * `GtkColumnViewCell`s exist in 2 stages:
 * 1. The unbound stage where the listitem is not currently connected to
 * an item in the list. In that case, the [Gtk.ColumnViewCell.item]
 * property is set to %NULL.
 * 2. The bound stage where the listitem references an item from the list.
 * The [Gtk.ColumnViewCell.item] property is not %NULL.
 */
class ColumnViewCell : ListItem
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
    return gtk_column_view_cell_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the child previously set via [Gtk.ColumnViewCell.setChild] or
   * %NULL if none was set.
   * Returns: The child
   */
  override Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_column_view_cell_get_child(cast(GtkColumnViewCell*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if a list item has been set to be focusable via
   * [Gtk.ColumnViewCell.setFocusable].
   * Returns: %TRUE if the item is focusable
   */
  override bool getFocusable()
  {
    bool _retval;
    _retval = gtk_column_view_cell_get_focusable(cast(GtkColumnViewCell*)cPtr);
    return _retval;
  }

  /**
   * Gets the model item that associated with self.
   * If self is unbound, this function returns %NULL.
   * Returns: The item displayed
   */
  override ObjectG getItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_column_view_cell_get_item(cast(GtkColumnViewCell*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the position in the model that self currently displays.
   * If self is unbound, %GTK_INVALID_LIST_POSITION is returned.
   * Returns: The position of this item
   */
  override uint getPosition()
  {
    uint _retval;
    _retval = gtk_column_view_cell_get_position(cast(GtkColumnViewCell*)cPtr);
    return _retval;
  }

  /**
   * Checks if the item is displayed as selected.
   * The selected state is maintained by the liste widget and its model
   * and cannot be set otherwise.
   * Returns: %TRUE if the item is selected.
   */
  override bool getSelected()
  {
    bool _retval;
    _retval = gtk_column_view_cell_get_selected(cast(GtkColumnViewCell*)cPtr);
    return _retval;
  }

  /**
   * Sets the child to be used for this listitem.
   * This function is typically called by applications when
   * setting up a listitem so that the widget can be reused when
   * binding it multiple times.
   * Params:
   *   child = The list item's child or %NULL to unset
   */
  override void setChild(Widget child)
  {
    gtk_column_view_cell_set_child(cast(GtkColumnViewCell*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
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
  override void setFocusable(bool focusable)
  {
    gtk_column_view_cell_set_focusable(cast(GtkColumnViewCell*)cPtr, focusable);
  }
}
