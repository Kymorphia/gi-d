module Gio.ActionEntry;

import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This struct defines a single action.  It is for use with
 * [Gio.ActionMap.addActionEntries].
 * The order of the items in the structure are intended to reflect
 * frequency of use.  It is permissible to use an incomplete initialiser
 * in order to leave some of the later values as %NULL.  All values
 * after @name are optional.  Additional optional fields may be added in
 * the future.
 * See [Gio.ActionMap.addActionEntries] for an example.
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string name()
  {
    return (cast(GActionEntry*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GActionEntry*)cPtr).name);
    (cast(GActionEntry*)cPtr).name = propval.toCString(true);
  }

  alias ActivateFuncType = extern(C) void function(GSimpleAction* action, GVariant* parameter, void* userData);

  @property ActivateFuncType activate()
  {
    return (cast(GActionEntry*)cPtr).activate;
  }

  @property string parameterType()
  {
    return (cast(GActionEntry*)cPtr).parameterType.fromCString(false);
  }

  @property void parameterType(string propval)
  {
    safeFree(cast(void*)(cast(GActionEntry*)cPtr).parameterType);
    (cast(GActionEntry*)cPtr).parameterType = propval.toCString(true);
  }

  @property string state()
  {
    return (cast(GActionEntry*)cPtr).state.fromCString(false);
  }

  @property void state(string propval)
  {
    safeFree(cast(void*)(cast(GActionEntry*)cPtr).state);
    (cast(GActionEntry*)cPtr).state = propval.toCString(true);
  }

  alias ChangeStateFuncType = extern(C) void function(GSimpleAction* action, GVariant* value, void* userData);

  @property ChangeStateFuncType changeState()
  {
    return (cast(GActionEntry*)cPtr).changeState;
  }
}
