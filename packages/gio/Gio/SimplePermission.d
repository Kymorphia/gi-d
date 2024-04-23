module Gio.SimplePermission;

import GObject.ObjectG;
import Gid.Gid;
import Gio.Permission;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSimplePermission is a trivial implementation of #GPermission that
 * represents a permission that is either always or never allowed.  The
 * value is given at construction and doesn't change.
 *
 * Calling request or release will result in errors.
 */
class SimplePermission : Permission
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_permission_get_type();
  }

  /**
   * the #GSimplePermission, as a #GPermission
   */
  this(bool allowed)
  {
    GPermission* _cretval;
    _cretval = g_simple_permission_new(allowed);
    this(_cretval, true);
  }
}
