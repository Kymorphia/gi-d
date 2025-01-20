module GObject.InitiallyUnowned;

import GObject.ObjectG;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A type for objects that have an initially floating reference.
 * All the fields in the `GInitiallyUnowned` structure are private to the
 * implementation and should never be accessed directly.
 */
class InitiallyUnowned : ObjectG
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
    return g_initially_unowned_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
