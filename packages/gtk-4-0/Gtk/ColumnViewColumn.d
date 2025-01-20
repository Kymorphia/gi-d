module Gtk.ColumnViewColumn;

import GObject.ObjectG;
import Gid.gid;
import Gio.MenuModel;
import Gtk.ColumnView;
import Gtk.ListItemFactory;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkColumnViewColumn` represents the columns being added to a `GtkColumnView`.
 * The main ingredient for a `GtkColumnViewColumn` is the `GtkListItemFactory`
 * that tells the columnview how to create cells for this column from items in
 * the model.
 * Columns have a title, and can optionally have a header menu set
 * with [Gtk.ColumnViewColumn.setHeaderMenu].
 * A sorter can be associated with a column using
 * [Gtk.ColumnViewColumn.setSorter], to let users influence sorting
 * by clicking on the column header.
 */
class ColumnViewColumn : ObjectG
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
    return gtk_column_view_column_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkColumnViewColumn` that uses the given factory for
   * mapping items to widgets.
   * You most likely want to call [Gtk.ColumnView.appendColumn] next.
   * The function takes ownership of the argument, so you can write code like:
   * ```c
   * column \= gtk_column_view_column_new $(LPAREN)_$(LPAREN)"Name"$(RPAREN),
   * gtk_builder_list_item_factory_new_from_resource $(LPAREN)"/name.ui"$(RPAREN)$(RPAREN);
   * ```
   * Params:
   *   title = Title to use for this column
   *   factory = The factory to populate items with
   * Returns: a new `GtkColumnViewColumn` using the given factory
   */
  this(string title, ListItemFactory factory)
  {
    GtkColumnViewColumn* _cretval;
    const(char)* _title = title.toCString(false);
    _cretval = gtk_column_view_column_new(_title, factory ? cast(GtkListItemFactory*)factory.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Gets the column view that's currently displaying this column.
   * If self has not been added to a column view yet, %NULL is returned.
   * Returns: The column view displaying self.
   */
  ColumnView getColumnView()
  {
    GtkColumnView* _cretval;
    _cretval = gtk_column_view_column_get_column_view(cast(GtkColumnViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ColumnView(cast(GtkColumnView*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether this column should expand.
   * Returns: %TRUE if this column expands
   */
  bool getExpand()
  {
    bool _retval;
    _retval = gtk_column_view_column_get_expand(cast(GtkColumnViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Gets the factory that's currently used to populate list items for
   * this column.
   * Returns: The factory in use
   */
  ListItemFactory getFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_column_view_column_get_factory(cast(GtkColumnViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the fixed width of the column.
   * Returns: the fixed with of the column
   */
  int getFixedWidth()
  {
    int _retval;
    _retval = gtk_column_view_column_get_fixed_width(cast(GtkColumnViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Gets the menu model that is used to create the context menu
   * for the column header.
   * Returns: the `GMenuModel`
   */
  MenuModel getHeaderMenu()
  {
    GMenuModel* _cretval;
    _cretval = gtk_column_view_column_get_header_menu(cast(GtkColumnViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the ID set with [Gtk.ColumnViewColumn.setId].
   * Returns: The column's ID
   */
  string getId()
  {
    const(char)* _cretval;
    _cretval = gtk_column_view_column_get_id(cast(GtkColumnViewColumn*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether this column is resizable.
   * Returns: %TRUE if this column is resizable
   */
  bool getResizable()
  {
    bool _retval;
    _retval = gtk_column_view_column_get_resizable(cast(GtkColumnViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the sorter that is associated with the column.
   * Returns: the `GtkSorter` of self
   */
  Sorter getSorter()
  {
    GtkSorter* _cretval;
    _cretval = gtk_column_view_column_get_sorter(cast(GtkColumnViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Sorter(cast(GtkSorter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the title set with [Gtk.ColumnViewColumn.setTitle].
   * Returns: The column's title
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_column_view_column_get_title(cast(GtkColumnViewColumn*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether this column is visible.
   * Returns: %TRUE if this column is visible
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_column_view_column_get_visible(cast(GtkColumnViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Sets the column to take available extra space.
   * The extra space is shared equally amongst all columns that
   * have the expand set to %TRUE.
   * Params:
   *   expand = %TRUE if this column should expand to fill available sace
   */
  void setExpand(bool expand)
  {
    gtk_column_view_column_set_expand(cast(GtkColumnViewColumn*)cPtr, expand);
  }

  /**
   * Sets the `GtkListItemFactory` to use for populating list items for this
   * column.
   * Params:
   *   factory = the factory to use
   */
  void setFactory(ListItemFactory factory)
  {
    gtk_column_view_column_set_factory(cast(GtkColumnViewColumn*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(false) : null);
  }

  /**
   * If fixed_width is not -1, sets the fixed width of column;
   * otherwise unsets it.
   * Setting a fixed width overrides the automatically calculated
   * width. Interactive resizing also sets the “fixed-width” property.
   * Params:
   *   fixedWidth = the new fixed width, or -1
   */
  void setFixedWidth(int fixedWidth)
  {
    gtk_column_view_column_set_fixed_width(cast(GtkColumnViewColumn*)cPtr, fixedWidth);
  }

  /**
   * Sets the menu model that is used to create the context menu
   * for the column header.
   * Params:
   *   menu = a `GMenuModel`
   */
  void setHeaderMenu(MenuModel menu)
  {
    gtk_column_view_column_set_header_menu(cast(GtkColumnViewColumn*)cPtr, menu ? cast(GMenuModel*)menu.cPtr(false) : null);
  }

  /**
   * Sets the id of this column.
   * GTK makes no use of this, but applications can use it when
   * storing column view configuration.
   * It is up to callers to ensure uniqueness of IDs.
   * Params:
   *   id = ID to use for this column
   */
  void setId(string id)
  {
    const(char)* _id = id.toCString(false);
    gtk_column_view_column_set_id(cast(GtkColumnViewColumn*)cPtr, _id);
  }

  /**
   * Sets whether this column should be resizable by dragging.
   * Params:
   *   resizable = whether this column should be resizable
   */
  void setResizable(bool resizable)
  {
    gtk_column_view_column_set_resizable(cast(GtkColumnViewColumn*)cPtr, resizable);
  }

  /**
   * Associates a sorter with the column.
   * If sorter is %NULL, the column will not let users change
   * the sorting by clicking on its header.
   * This sorter can be made active by clicking on the column
   * header, or by calling [Gtk.ColumnView.sortByColumn].
   * See [Gtk.ColumnView.getSorter] for the necessary steps
   * for setting up customizable sorting for [Gtk.ColumnView].
   * Params:
   *   sorter = the `GtkSorter` to associate with column
   */
  void setSorter(Sorter sorter)
  {
    gtk_column_view_column_set_sorter(cast(GtkColumnViewColumn*)cPtr, sorter ? cast(GtkSorter*)sorter.cPtr(false) : null);
  }

  /**
   * Sets the title of this column.
   * The title is displayed in the header of a `GtkColumnView`
   * for this column and is therefore user-facing text that should
   * be translated.
   * Params:
   *   title = Title to use for this column
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_column_view_column_set_title(cast(GtkColumnViewColumn*)cPtr, _title);
  }

  /**
   * Sets whether this column should be visible in views.
   * Params:
   *   visible = whether this column should be visible
   */
  void setVisible(bool visible)
  {
    gtk_column_view_column_set_visible(cast(GtkColumnViewColumn*)cPtr, visible);
  }
}
