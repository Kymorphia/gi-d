module Gtk.ComboBoxText;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellEditable;
import Gtk.CellEditableT;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.ComboBox;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkComboBoxText` is a simple variant of `GtkComboBox` for text-only
 * use cases.
 * ![An example GtkComboBoxText](combo-box-text.png)
 * `GtkComboBoxText` hides the model-view complexity of `GtkComboBox`.
 * To create a `GtkComboBoxText`, use [Gtk.ComboBoxText.new_] or
 * [Gtk.ComboBoxText.newWithEntry].
 * You can add items to a `GtkComboBoxText` with
 * [Gtk.ComboBoxText.appendText],
 * [Gtk.ComboBoxText.insertText] or
 * [Gtk.ComboBoxText.prependText] and remove options with
 * [Gtk.ComboBoxText.remove].
 * If the `GtkComboBoxText` contains an entry $(LPAREN)via the
 * property@Gtk.ComboBox:has-entry property$(RPAREN), its contents can be retrieved
 * using [Gtk.ComboBoxText.getActiveText].
 * You should not call [Gtk.ComboBox.setModel] or attempt to pack more
 * cells into this combo box via its [Gtk.CellLayout] interface.
 * ## GtkComboBoxText as GtkBuildable
 * The `GtkComboBoxText` implementation of the `GtkBuildable` interface supports
 * adding items directly using the `<items>` element and specifying `<item>`
 * elements for each item. Each `<item>` element can specify the “id”
 * corresponding to the appended text and also supports the regular
 * translation attributes “translatable”, “context” and “comments”.
 * Here is a UI definition fragment specifying `GtkComboBoxText` items:
 * ```xml
 * <object class\="GtkComboBoxText">
 * <items>
 * <item translatable\="yes" id\="factory">Factory</item>
 * <item translatable\="yes" id\="home">Home</item>
 * <item translatable\="yes" id\="subway">Subway</item>
 * </items>
 * </object>
 * ```
 * ## CSS nodes
 * ```
 * combobox
 * ╰── box.linked
 * ├── entry.combo
 * ├── button.combo
 * ╰── window.popup
 * ```
 * `GtkComboBoxText` has a single CSS node with name combobox. It adds
 * the style class .combo to the main CSS nodes of its entry and button
 * children, and the .linked class to the node of its internal box.

 * Deprecated: Use [Gtk.DropDown] with a [Gtk.StringList]
 *   instead
 */
class ComboBoxText : ComboBox
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_combo_box_text_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkComboBoxText`.
   * Returns: A new `GtkComboBoxText`

   * Deprecated: Use [Gtk.DropDown]
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_text_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkComboBoxText` with an entry.
   * Returns: a new `GtkComboBoxText`

   * Deprecated: Use [Gtk.DropDown]
   */
  static ComboBoxText newWithEntry()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_text_new_with_entry();
    auto _retval = _cretval ? ObjectG.getDObject!ComboBoxText(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Appends text to the list of strings stored in combo_box.
   * If id is non-%NULL then it is used as the ID of the row.
   * This is the same as calling [Gtk.ComboBoxText.insert]
   * with a position of -1.
   * Params:
   *   id = a string ID for this value
   *   text = A string

   * Deprecated: Use [Gtk.DropDown]
   */
  void append(string id, string text)
  {
    const(char)* _id = id.toCString(false);
    const(char)* _text = text.toCString(false);
    gtk_combo_box_text_append(cast(GtkComboBoxText*)cPtr, _id, _text);
  }

  /**
   * Appends text to the list of strings stored in combo_box.
   * This is the same as calling [Gtk.ComboBoxText.insertText]
   * with a position of -1.
   * Params:
   *   text = A string

   * Deprecated: Use [Gtk.DropDown]
   */
  void appendText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_combo_box_text_append_text(cast(GtkComboBoxText*)cPtr, _text);
  }

  /**
   * Returns the currently active string in combo_box.
   * If no row is currently selected, %NULL is returned.
   * If combo_box contains an entry, this function will
   * return its contents $(LPAREN)which will not necessarily
   * be an item from the list$(RPAREN).
   * Returns: a newly allocated
   *   string containing the currently active text.
   *   Must be freed with [GLib.Global.gfree].

   * Deprecated: Use [Gtk.DropDown]
   */
  string getActiveText()
  {
    char* _cretval;
    _cretval = gtk_combo_box_text_get_active_text(cast(GtkComboBoxText*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Inserts text at position in the list of strings stored in combo_box.
   * If id is non-%NULL then it is used as the ID of the row.
   * See propertyGtk.ComboBox:id-column.
   * If position is negative then text is appended.
   * Params:
   *   position = An index to insert text
   *   id = a string ID for this value
   *   text = A string to display

   * Deprecated: Use [Gtk.DropDown]
   */
  void insert(int position, string id, string text)
  {
    const(char)* _id = id.toCString(false);
    const(char)* _text = text.toCString(false);
    gtk_combo_box_text_insert(cast(GtkComboBoxText*)cPtr, position, _id, _text);
  }

  /**
   * Inserts text at position in the list of strings stored in combo_box.
   * If position is negative then text is appended.
   * This is the same as calling [Gtk.ComboBoxText.insert]
   * with a %NULL ID string.
   * Params:
   *   position = An index to insert text
   *   text = A string

   * Deprecated: Use [Gtk.DropDown]
   */
  void insertText(int position, string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_combo_box_text_insert_text(cast(GtkComboBoxText*)cPtr, position, _text);
  }

  /**
   * Prepends text to the list of strings stored in combo_box.
   * If id is non-%NULL then it is used as the ID of the row.
   * This is the same as calling [Gtk.ComboBoxText.insert]
   * with a position of 0.
   * Params:
   *   id = a string ID for this value
   *   text = a string

   * Deprecated: Use [Gtk.DropDown]
   */
  void prepend(string id, string text)
  {
    const(char)* _id = id.toCString(false);
    const(char)* _text = text.toCString(false);
    gtk_combo_box_text_prepend(cast(GtkComboBoxText*)cPtr, _id, _text);
  }

  /**
   * Prepends text to the list of strings stored in combo_box.
   * This is the same as calling [Gtk.ComboBoxText.insertText]
   * with a position of 0.
   * Params:
   *   text = A string

   * Deprecated: Use [Gtk.DropDown]
   */
  void prependText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_combo_box_text_prepend_text(cast(GtkComboBoxText*)cPtr, _text);
  }

  /**
   * Removes the string at position from combo_box.
   * Params:
   *   position = Index of the item to remove

   * Deprecated: Use [Gtk.DropDown]
   */
  void remove(int position)
  {
    gtk_combo_box_text_remove(cast(GtkComboBoxText*)cPtr, position);
  }

  /**
   * Removes all the text entries from the combo box.

   * Deprecated: Use [Gtk.DropDown]
   */
  void removeAll()
  {
    gtk_combo_box_text_remove_all(cast(GtkComboBoxText*)cPtr);
  }
}
