module Gtk.StringObject;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkStringObject` is the type of items in a `GtkStringList`.
 * A `GtkStringObject` is a wrapper around a `const char*`; it has
 * a [Gtk.StringObject.string] property that can be used
 * for property bindings and expressions.
 */
class StringObject : ObjectG
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
    return gtk_string_object_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Wraps a string in an object for use with `GListModel`.
   * Params:
   *   string_ = The string to wrap
   * Returns: a new `GtkStringObject`
   */
  this(string string_)
  {
    GtkStringObject* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = gtk_string_object_new(_string_);
    this(_cretval, true);
  }

  /**
   * Returns the string contained in a `GtkStringObject`.
   * Returns: the string of self
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = gtk_string_object_get_string(cast(GtkStringObject*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}
