module GLib.StaticPrivate;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A #GStaticPrivate works almost like a #GPrivate, but it has one
 * significant advantage. It doesn't need to be created at run-time
 * like a #GPrivate, but can be defined at compile-time. This is
 * similar to the difference between #GMutex and #GStaticMutex.
 * Now look at our give_me_next_number$(LPAREN)$(RPAREN) example with #GStaticPrivate:
 * |[
 * int
 * give_me_next_number $(LPAREN)$(RPAREN)
 * {
 * static GStaticPrivate current_number_key \= G_STATIC_PRIVATE_INIT;
 * int *current_number \= g_static_private_get $(LPAREN)&current_number_key$(RPAREN);
 * if $(LPAREN)!current_number$(RPAREN)
 * {
 * current_number \= g_new $(LPAREN)int, 1$(RPAREN);
 * *current_number \= 0;
 * g_static_private_set $(LPAREN)&current_number_key, current_number, g_free$(RPAREN);
 * }
 * *current_number \= calc_next_number $(LPAREN)*current_number$(RPAREN);
 * return *current_number;
 * }
 * ]|
 */
class StaticPrivate
{
  GStaticPrivate cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.StaticPrivate");

    cInstance = *cast(GStaticPrivate*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
