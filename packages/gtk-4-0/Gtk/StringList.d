module Gtk.StringList;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkStringList` is a list model that wraps an array of strings.
 * The objects in the model are of type [Gtk.StringObject] and have
 * a "string" property that can be used inside expressions.
 * `GtkStringList` is well-suited for any place where you would
 * typically use a `char*[]`, but need a list model.
 * ## GtkStringList as GtkBuildable
 * The `GtkStringList` implementation of the `GtkBuildable` interface
 * supports adding items directly using the `<items>` element and
 * specifying `<item>` elements for each item. Each `<item>` element
 * supports the regular translation attributes “translatable”,
 * “context” and “comments”.
 * Here is a UI definition fragment specifying a `GtkStringList`
 * ```xml
 * <object class\="GtkStringList">
 * <items>
 * <item translatable\="yes">Factory</item>
 * <item translatable\="yes">Home</item>
 * <item translatable\="yes">Subway</item>
 * </items>
 * </object>
 * ```
 */
class StringList : ObjectG, ListModel, Buildable
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
    return gtk_string_list_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin BuildableT!();

  /**
   * Creates a new `GtkStringList` with the given strings.
   * Params:
   *   strings = The strings to put in the model
   * Returns: a new `GtkStringList`
   */
  this(string[] strings)
  {
    GtkStringList* _cretval;
    char*[] _tmpstrings;
    foreach (s; strings)
      _tmpstrings ~= s.toCString(false);
    _tmpstrings ~= null;
    const(char*)* _strings = _tmpstrings.ptr;
    _cretval = gtk_string_list_new(_strings);
    this(_cretval, true);
  }

  /**
   * Appends string to self.
   * The string will be copied. See
   * [Gtk.StringList.take] for a way to avoid that.
   * Params:
   *   string_ = the string to insert
   */
  void append(string string_)
  {
    const(char)* _string_ = string_.toCString(false);
    gtk_string_list_append(cast(GtkStringList*)cPtr, _string_);
  }

  /**
   * Gets the string that is at position in self.
   * If self does not contain position items, %NULL is returned.
   * This function returns the const char *. To get the
   * object wrapping it, use [Gio.ListModel.getItem].
   * Params:
   *   position = the position to get the string for
   * Returns: the string at the given position
   */
  string getString(uint position)
  {
    const(char)* _cretval;
    _cretval = gtk_string_list_get_string(cast(GtkStringList*)cPtr, position);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Removes the string at position from self.
   * position must be smaller than the current
   * length of the list.
   * Params:
   *   position = the position of the string that is to be removed
   */
  void remove(uint position)
  {
    gtk_string_list_remove(cast(GtkStringList*)cPtr, position);
  }

  /**
   * Changes self by removing n_removals strings and adding additions
   * to it.
   * This function is more efficient than [Gtk.StringList.append]
   * and [Gtk.StringList.remove], because it only emits the
   * ::items-changed signal once for the change.
   * This function copies the strings in additions.
   * The parameters position and n_removals must be correct $(LPAREN)ie:
   * position + n_removals must be less than or equal to the length
   * of the list at the time this function is called$(RPAREN).
   * Params:
   *   position = the position at which to make the change
   *   nRemovals = the number of strings to remove
   *   additions = The strings to add
   */
  void splice(uint position, uint nRemovals, string[] additions)
  {
    char*[] _tmpadditions;
    foreach (s; additions)
      _tmpadditions ~= s.toCString(false);
    _tmpadditions ~= null;
    const(char*)* _additions = _tmpadditions.ptr;
    gtk_string_list_splice(cast(GtkStringList*)cPtr, position, nRemovals, _additions);
  }

  /**
   * Adds string to self at the end, and takes
   * ownership of it.
   * This variant of [Gtk.StringList.append]
   * is convenient for formatting strings:
   * ```c
   * gtk_string_list_take $(LPAREN)self, g_strdup_print $(LPAREN)"%d dollars", lots$(RPAREN)$(RPAREN);
   * ```
   * Params:
   *   string_ = the string to insert
   */
  void take(string string_)
  {
    char* _string_ = string_.toCString(true);
    gtk_string_list_take(cast(GtkStringList*)cPtr, _string_);
  }
}
