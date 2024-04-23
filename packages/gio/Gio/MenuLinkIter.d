module Gio.MenuLinkIter;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.MenuModel;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMenuLinkIter is an opaque structure type.  You must access it using
 * the functions below.
 */
class MenuLinkIter : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_menu_link_iter_get_type();
  }

  /**
   * the type of the link
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_menu_link_iter_get_name(cPtr!GMenuLinkIter);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE on success, or %FALSE if there is no additional link
   */
  bool getNext(out string outLink, out MenuModel value)
  {
    bool _retval;
    char* _outLink;
    GMenuModel* _value;
    _retval = g_menu_link_iter_get_next(cPtr!GMenuLinkIter, &_outLink, &_value);
    outLink = _outLink.fromCString(false);
    value = new MenuModel(cast(void*)_value, true);
    return _retval;
  }

  /**
   * the #GMenuModel that is linked to
   */
  MenuModel getValue()
  {
    GMenuModel* _cretval;
    _cretval = g_menu_link_iter_get_value(cPtr!GMenuLinkIter);
    MenuModel _retval = ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE on success, or %FALSE when there are no more links
   */
  bool next()
  {
    bool _retval;
    _retval = g_menu_link_iter_next(cPtr!GMenuLinkIter);
    return _retval;
  }
}
