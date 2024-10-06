module Gtk.AccessibleList;

import GLib.Boxed;
import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A boxed type which wraps a list of references to GtkAccessible objects.
 */
class AccessibleList : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gtk_accessible_list_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new list of accessible instances.
   * Params:
   *   accessibles = array of GtkAccessible
   * Returns: the newly created list of accessible instances
   */
  static AccessibleList newFromArray(Accessible[] accessibles)
  {
    GtkAccessibleList* _cretval;
    size_t _nAccessibles;
    if (accessibles)
      _nAccessibles = cast(size_t)accessibles.length;

    GtkAccessible*[] _tmpaccessibles;
    foreach (obj; accessibles)
      _tmpaccessibles ~= obj ? cast(GtkAccessible*)(cast(ObjectG)obj).cPtr : null;
    GtkAccessible** _accessibles = _tmpaccessibles.ptr;
    _cretval = gtk_accessible_list_new_from_array(_accessibles, _nAccessibles);
    auto _retval = _cretval ? new AccessibleList(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Allocates a new `GtkAccessibleList`, doing a shallow copy of the
   * passed list of `GtkAccessible` instances.
   * Params:
   *   list = a reference to a `GList` containing a list of accessible values
   * Returns: the list of accessible instances
   */
  static AccessibleList newFromList(List!(Accessible, GtkAccessible) list)
  {
    GtkAccessibleList* _cretval;
    _cretval = gtk_accessible_list_new_from_list(list.cPtr);
    auto _retval = _cretval ? new AccessibleList(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the list of objects this boxed type holds
   * Returns: a shallow copy of the objects
   */
  List!(Accessible, GtkAccessible) getObjects()
  {
    GList* _cretval;
    _cretval = gtk_accessible_list_get_objects(cast(GtkAccessibleList*)cPtr);
    List!(Accessible, GtkAccessible) _retval = new List!(Accessible, GtkAccessible)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }
}