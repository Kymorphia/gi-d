module Gio.MenuAttributeIter;

import GLib.Types;
import GLib.Variant;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMenuAttributeIter is an opaque structure type.  You must access it
 * using the functions below.
 */
class MenuAttributeIter : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_menu_attribute_iter_get_type();
  }

  /**
   * the name of the attribute
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_menu_attribute_iter_get_name(cPtr!GMenuAttributeIter);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE on success, or %FALSE if there is no additional
   * attribute
   */
  bool getNext(out string outName, out Variant value)
  {
    bool _retval;
    char* _outName;
    GVariant* _value;
    _retval = g_menu_attribute_iter_get_next(cPtr!GMenuAttributeIter, &_outName, &_value);
    outName = _outName.fromCString(false);
    value = new Variant(cast(void*)_value, true);
    return _retval;
  }

  /**
   * the value of the current attribute
   */
  Variant getValue()
  {
    GVariant* _cretval;
    _cretval = g_menu_attribute_iter_get_value(cPtr!GMenuAttributeIter);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE on success, or %FALSE when there are no more attributes
   */
  bool next()
  {
    bool _retval;
    _retval = g_menu_attribute_iter_next(cPtr!GMenuAttributeIter);
    return _retval;
  }
}
