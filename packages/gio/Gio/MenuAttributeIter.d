module Gio.MenuAttributeIter;

import GLib.Variant;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMenuAttributeIter is an opaque structure type.  You must access it
 * using the functions below.
 */
class MenuAttributeIter : ObjectG
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
    return g_menu_attribute_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the name of the attribute at the current iterator position, as
   * a string.
   * The iterator is not advanced.
   * Returns: the name of the attribute
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_menu_attribute_iter_get_name(cast(GMenuAttributeIter*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * This function combines [Gio.MenuAttributeIter.next] with
   * [Gio.MenuAttributeIter.getName] and [Gio.MenuAttributeIter.getValue].
   * First the iterator is advanced to the next $(LPAREN)possibly first$(RPAREN) attribute.
   * If that fails, then %FALSE is returned and there are no other
   * effects.
   * If successful, name and value are set to the name and value of the
   * attribute that has just been advanced to.  At this point,
   * [Gio.MenuAttributeIter.getName] and [Gio.MenuAttributeIter.getValue] will
   * return the same values again.
   * The value returned in name remains valid for as long as the iterator
   * remains at the current position.  The value returned in value must
   * be unreffed using [GLib.Variant.unref] when it is no longer in use.
   * Params:
   *   outName = the type of the attribute
   *   value = the attribute value
   * Returns: %TRUE on success, or %FALSE if there is no additional
   *   attribute
   */
  bool getNext(out string outName, out Variant value)
  {
    bool _retval;
    char* _outName;
    GVariant* _value;
    _retval = g_menu_attribute_iter_get_next(cast(GMenuAttributeIter*)cPtr, &_outName, &_value);
    outName = _outName.fromCString(false);
    value = new Variant(cast(void*)_value, true);
    return _retval;
  }

  /**
   * Gets the value of the attribute at the current iterator position.
   * The iterator is not advanced.
   * Returns: the value of the current attribute
   */
  Variant getValue()
  {
    GVariant* _cretval;
    _cretval = g_menu_attribute_iter_get_value(cast(GMenuAttributeIter*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Attempts to advance the iterator to the next $(LPAREN)possibly first$(RPAREN)
   * attribute.
   * %TRUE is returned on success, or %FALSE if there are no more
   * attributes.
   * You must call this function when you first acquire the iterator
   * to advance it to the first attribute $(LPAREN)and determine if the first
   * attribute exists at all$(RPAREN).
   * Returns: %TRUE on success, or %FALSE when there are no more attributes
   */
  bool next()
  {
    bool _retval;
    _retval = g_menu_attribute_iter_next(cast(GMenuAttributeIter*)cPtr);
    return _retval;
  }
}
