module GLib.StaticRecMutex;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A #GStaticRecMutex works like a #GStaticMutex, but it can be locked
 * multiple times by one thread. If you enter it n times, you have to
 * unlock it n times again to let other threads lock it. An exception
 * is the function [GLib.StaticRecMutex.unlockFull]: that allows you to
 * unlock a #GStaticRecMutex completely returning the depth, $(LPAREN)i.e. the
 * number of times this mutex was locked$(RPAREN). The depth can later be used
 * to restore the state of the #GStaticRecMutex by calling
 * [GLib.StaticRecMutex.lockFull]. In GLib 2.32, #GStaticRecMutex has
 * been deprecated in favor of #GRecMutex.
 * Even though #GStaticRecMutex is not opaque, it should only be used
 * with the following functions.
 * All of the g_static_rec_mutex_* functions can be used even if
 * [GLib.Thread.init_] has not been called. Then they do nothing, apart
 * from [GLib.StaticRecMutex.trylock], which does nothing but returning
 * %TRUE.
 */
class StaticRecMutex
{
  GStaticRecMutex cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.StaticRecMutex");

    cInstance = *cast(GStaticRecMutex*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
