module GdkPixbuf.PixbufModulePattern;

import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * The signature prefix for a module.
 * The signature of a module is a set of prefixes. Prefixes are encoded as
 * pairs of ordinary strings, where the second string, called the mask, if
 * not `NULL`, must be of the same length as the first one and may contain
 * ' ', '!', 'x', 'z', and 'n' to indicate bytes that must be matched,
 * not matched, "don't-care"-bytes, zeros and non-zeros, respectively.
 * Each prefix has an associated integer that describes the relevance of
 * the prefix, with 0 meaning a mismatch and 100 a "perfect match".
 * Starting with gdk-pixbuf 2.8, the first byte of the mask may be '*',
 * indicating an unanchored pattern that matches not only at the beginning,
 * but also in the middle. Versions prior to 2.8 will interpret the '*'
 * like an 'x'.
 * The signature of a module is stored as an array of
 * `GdkPixbufModulePatterns`. The array is terminated by a pattern
 * where the `prefix` is `NULL`.
 * ```c
 * GdkPixbufModulePattern *signature[] \= {
 * { "abcdx", " !x z", 100 },
 * { "bla", NULL,  90 },
 * { NULL, NULL, 0 }
 * };
 * ```
 * In the example above, the signature matches e.g. "auud\0" with
 * relevance 100, and "blau" with relevance 90.
 */
class PixbufModulePattern
{
  GdkPixbufModulePattern cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GdkPixbuf.PixbufModulePattern");

    cInstance = *cast(GdkPixbufModulePattern*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string prefix()
  {
    return (cast(GdkPixbufModulePattern*)cPtr).prefix.fromCString(false);
  }

  @property void prefix(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufModulePattern*)cPtr).prefix);
    (cast(GdkPixbufModulePattern*)cPtr).prefix = propval.toCString(true);
  }

  @property string mask()
  {
    return (cast(GdkPixbufModulePattern*)cPtr).mask.fromCString(false);
  }

  @property void mask(string propval)
  {
    safeFree(cast(void*)(cast(GdkPixbufModulePattern*)cPtr).mask);
    (cast(GdkPixbufModulePattern*)cPtr).mask = propval.toCString(true);
  }

  @property int relevance()
  {
    return (cast(GdkPixbufModulePattern*)cPtr).relevance;
  }

  @property void relevance(int propval)
  {
    (cast(GdkPixbufModulePattern*)cPtr).relevance = propval;
  }
}
