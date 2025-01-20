module Gio.SimplePermission;

import Gid.gid;
import Gio.Permission;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GSimplePermission` is a trivial implementation of [Gio.Permission]
 * that represents a permission that is either always or never allowed.  The
 * value is given at construction and doesn’t change.
 * Calling [Gio.Permission.acquire] or [Gio.Permission.release]
 * on a `GSimplePermission` will result in errors.
 */
class SimplePermission : Permission
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
    return g_simple_permission_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GPermission instance that represents an action that is
   * either always or never allowed.
   * Params:
   *   allowed = %TRUE if the action is allowed
   * Returns: the #GSimplePermission, as a #GPermission
   */
  this(bool allowed)
  {
    GPermission* _cretval;
    _cretval = g_simple_permission_new(allowed);
    this(_cretval, true);
  }
}
