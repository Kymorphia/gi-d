module Gtk.ColumnViewRow;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkColumnViewRow` is used by [Gtk.ColumnView] to allow configuring
 * how rows are displayed.
 * It is not used to set the widgets displayed in the individual cells. For that
 * see method@GtkColumnViewColumn.set_factory and class@GtkColumnViewCell.
 */
class ColumnViewRow : ObjectG
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
    return gtk_column_view_row_get_type();
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
    _cretval = gtk_column_view_row_get_accessible_description(cast(GtkColumnViewRow*)cPtr);
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
    _cretval = gtk_column_view_row_get_accessible_label(cast(GtkColumnViewRow*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Checks if the row has been set to be activatable via
   * [Gtk.ColumnViewRow.setActivatable].
   * Returns: %TRUE if the row is activatable
   */
  bool getActivatable()
  {
    bool _retval;
    _retval = gtk_column_view_row_get_activatable(cast(GtkColumnViewRow*)cPtr);
    return _retval;
  }

  /**
   * Checks if a row item has been set to be focusable via
   * [Gtk.ColumnViewRow.setFocusable].
   * Returns: %TRUE if the row is focusable
   */
  bool getFocusable()
  {
    bool _retval;
    _retval = gtk_column_view_row_get_focusable(cast(GtkColumnViewRow*)cPtr);
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
    _cretval = gtk_column_view_row_get_item(cast(GtkColumnViewRow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the position in the model that self currently displays.
   * If self is unbound, %GTK_INVALID_LIST_POSITION is returned.
   * Returns: The position of this row
   */
  uint getPosition()
  {
    uint _retval;
    _retval = gtk_column_view_row_get_position(cast(GtkColumnViewRow*)cPtr);
    return _retval;
  }

  /**
   * Checks if the row has been set to be selectable via
   * [Gtk.ColumnViewRow.setSelectable].
   * Do not confuse this function with [Gtk.ColumnViewRow.getSelected].
   * Returns: %TRUE if the row is selectable
   */
  bool getSelectable()
  {
    bool _retval;
    _retval = gtk_column_view_row_get_selectable(cast(GtkColumnViewRow*)cPtr);
    return _retval;
  }

  /**
   * Checks if the item is selected that this row corresponds to.
   * The selected state is maintained by the list widget and its model
   * and cannot be set otherwise.
   * Returns: %TRUE if the item is selected.
   */
  bool getSelected()
  {
    bool _retval;
    _retval = gtk_column_view_row_get_selected(cast(GtkColumnViewRow*)cPtr);
    return _retval;
  }

  /**
   * Sets the accessible description for the row,
   * which may be used by e.g. screen readers.
   * Params:
   *   description = the description
   */
  void setAccessibleDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    gtk_column_view_row_set_accessible_description(cast(GtkColumnViewRow*)cPtr, _description);
  }

  /**
   * Sets the accessible label for the row,
   * which may be used by e.g. screen readers.
   * Params:
   *   label = the label
   */
  void setAccessibleLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_column_view_row_set_accessible_label(cast(GtkColumnViewRow*)cPtr, _label);
  }

  /**
   * Sets self to be activatable.
   * If a row is activatable, double-clicking on the row, using
   * the Return key or calling [Gtk.Widget.activate] will activate
   * the row. Activating instructs the containing columnview to
   * emit the [Gtk.ColumnView.activate] signal.
   * By default, row are activatable.
   * Params:
   *   activatable = if the row should be activatable
   */
  void setActivatable(bool activatable)
  {
    gtk_column_view_row_set_activatable(cast(GtkColumnViewRow*)cPtr, activatable);
  }

  /**
   * Sets self to be focusable.
   * If a row is focusable, it can be focused using the keyboard.
   * This works similar to [Gtk.Widget.setFocusable].
   * Note that if row are not focusable, the contents of cells can still be focused if
   * they are focusable.
   * By default, rows are focusable.
   * Params:
   *   focusable = if the row should be focusable
   */
  void setFocusable(bool focusable)
  {
    gtk_column_view_row_set_focusable(cast(GtkColumnViewRow*)cPtr, focusable);
  }

  /**
   * Sets self to be selectable.
   * If a row is selectable, clicking on the row or using the keyboard
   * will try to select or unselect the row. Whether this succeeds is up to
   * the model to determine, as it is managing the selected state.
   * Note that this means that making a row non-selectable has no
   * influence on the selected state at all. A non-selectable row
   * may still be selected.
   * By default, rows are selectable.
   * Params:
   *   selectable = if the row should be selectable
   */
  void setSelectable(bool selectable)
  {
    gtk_column_view_row_set_selectable(cast(GtkColumnViewRow*)cPtr, selectable);
  }
}
