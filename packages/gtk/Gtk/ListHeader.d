module Gtk.ListHeader;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkListHeader` is used by list widgets to represent the headers they
 * display.
 * `GtkListHeader` objects are managed just like [Gtk.ListItem]
 * objects via their factory, but provide a different set of properties suitable
 * for managing the header instead of individual items.
 */
class ListHeader : ObjectG
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
    return gtk_list_header_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the child previously set via [Gtk.ListHeader.setChild] or
   * %NULL if none was set.
   * Returns: The child
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_list_header_get_child(cast(GtkListHeader*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the end position in the model of the section that self is
   * currently the header for.
   * If self is unbound, %GTK_INVALID_LIST_POSITION is returned.
   * Returns: The end position of the section
   */
  uint getEnd()
  {
    uint _retval;
    _retval = gtk_list_header_get_end(cast(GtkListHeader*)cPtr);
    return _retval;
  }

  /**
   * Gets the model item at the start of the section.
   * This is the item that occupies the list model at position
   * [Gtk.ListHeader.start].
   * If self is unbound, this function returns %NULL.
   * Returns: The item displayed
   */
  ObjectG getItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_list_header_get_item(cast(GtkListHeader*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the the number of items in the section.
   * If self is unbound, 0 is returned.
   * Returns: The number of items in the section
   */
  uint getNItems()
  {
    uint _retval;
    _retval = gtk_list_header_get_n_items(cast(GtkListHeader*)cPtr);
    return _retval;
  }

  /**
   * Gets the start position in the model of the section that self is
   * currently the header for.
   * If self is unbound, %GTK_INVALID_LIST_POSITION is returned.
   * Returns: The start position of the section
   */
  uint getStart()
  {
    uint _retval;
    _retval = gtk_list_header_get_start(cast(GtkListHeader*)cPtr);
    return _retval;
  }

  /**
   * Sets the child to be used for this listitem.
   * This function is typically called by applications when
   * setting up a header so that the widget can be reused when
   * binding it multiple times.
   * Params:
   *   child = The list item's child or %NULL to unset
   */
  void setChild(Widget child)
  {
    gtk_list_header_set_child(cast(GtkListHeader*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }
}
