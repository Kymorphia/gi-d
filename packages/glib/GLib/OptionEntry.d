module GLib.OptionEntry;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A GOptionEntry struct defines a single option. To have an effect, they
 * must be added to a #GOptionGroup with g_option_context_add_main_entries()
 * or g_option_group_add_entries().
 */
class OptionEntry
{
  GOptionEntry cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.OptionEntry");

    cInstance = *cast(GOptionEntry*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GOptionEntry))
  {
    return cast(T*)&cInstance;
  }

  @property string longName()
  {
    return cPtr!GOptionEntry.longName.fromCString(false);
  }

  @property void longName(string propval)
  {
    g_free(cast(void*)cPtr!GOptionEntry.longName);
    cPtr!GOptionEntry.longName = propval.toCString(true);
  }

  @property char shortName()
  {
    return cPtr!GOptionEntry.shortName;
  }

  @property void shortName(char propval)
  {
    cPtr!GOptionEntry.shortName = propval;
  }

  @property int flags()
  {
    return cPtr!GOptionEntry.flags;
  }

  @property void flags(int propval)
  {
    cPtr!GOptionEntry.flags = propval;
  }

  @property OptionArg arg()
  {
    return cast(OptionArg)cPtr!GOptionEntry.arg;
  }

  @property void arg(OptionArg propval)
  {
    cPtr!GOptionEntry.arg = cast(GOptionArg)propval;
  }

  @property string description()
  {
    return cPtr!GOptionEntry.description.fromCString(false);
  }

  @property void description(string propval)
  {
    g_free(cast(void*)cPtr!GOptionEntry.description);
    cPtr!GOptionEntry.description = propval.toCString(true);
  }

  @property string argDescription()
  {
    return cPtr!GOptionEntry.argDescription.fromCString(false);
  }

  @property void argDescription(string propval)
  {
    g_free(cast(void*)cPtr!GOptionEntry.argDescription);
    cPtr!GOptionEntry.argDescription = propval.toCString(true);
  }
}
