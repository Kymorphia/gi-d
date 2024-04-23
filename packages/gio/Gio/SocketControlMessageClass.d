module Gio.SocketControlMessageClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.SocketControlMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GSocketControlMessage.
 */
class SocketControlMessageClass
{
  GSocketControlMessageClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketControlMessageClass");

    cInstance = *cast(GSocketControlMessageClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketControlMessageClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSocketControlMessageClass.parentClass);
  }

  alias GetSizeFuncType = extern(C) size_t function(GSocketControlMessage* message);

  @property GetSizeFuncType getSize()
  {
    return cPtr!GSocketControlMessageClass.getSize;
  }

  alias GetLevelFuncType = extern(C) int function(GSocketControlMessage* message);

  @property GetLevelFuncType getLevel()
  {
    return cPtr!GSocketControlMessageClass.getLevel;
  }

  alias GetTypeFuncType = extern(C) int function(GSocketControlMessage* message);

  @property GetTypeFuncType getType()
  {
    return cPtr!GSocketControlMessageClass.getType;
  }

  alias SerializeFuncType = extern(C) void function(GSocketControlMessage* message, void* data);

  @property SerializeFuncType serialize()
  {
    return cPtr!GSocketControlMessageClass.serialize;
  }
}
