module Gio.ActionEntry;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import Gid.Gid;
import Gio.SimpleAction;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This struct defines a single action.  It is for use with
 * g_action_map_add_action_entries().
 *
 * The order of the items in the structure are intended to reflect
 * frequency of use.  It is permissible to use an incomplete initialiser
 * in order to leave some of the later values as %NULL.  All values
 * after @name are optional.  Additional optional fields may be added in
 * the future.
 *
 * See g_action_map_add_action_entries() for an example.
 */
class ActionEntry
{
  GActionEntry cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ActionEntry");

    cInstance = *cast(GActionEntry*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GActionEntry))
  {
    return cast(T*)&cInstance;
  }

  @property string name()
  {
    return cPtr!GActionEntry.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GActionEntry.name);
    cPtr!GActionEntry.name = propval.toCString(true);
  }

  alias ActivateFuncType = extern(C) void function(GSimpleAction* action, GVariant* parameter, void* userData);

  @property ActivateFuncType activate()
  {
    return cPtr!GActionEntry.activate;
  }

  @property string parameterType()
  {
    return cPtr!GActionEntry.parameterType.fromCString(false);
  }

  @property void parameterType(string propval)
  {
    g_free(cast(void*)cPtr!GActionEntry.parameterType);
    cPtr!GActionEntry.parameterType = propval.toCString(true);
  }

  @property string state()
  {
    return cPtr!GActionEntry.state.fromCString(false);
  }

  @property void state(string propval)
  {
    g_free(cast(void*)cPtr!GActionEntry.state);
    cPtr!GActionEntry.state = propval.toCString(true);
  }

  alias ChangeStateFuncType = extern(C) void function(GSimpleAction* action, GVariant* value, void* userData);

  @property ChangeStateFuncType changeState()
  {
    return cPtr!GActionEntry.changeState;
  }
}
