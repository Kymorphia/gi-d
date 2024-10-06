module Gio.SocketControlMessageClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GSocketControlMessageClass*)cPtr).parentClass);
  }

  alias GetSizeFuncType = extern(C) size_t function(GSocketControlMessage* message);

  @property GetSizeFuncType getSize()
  {
    return (cast(GSocketControlMessageClass*)cPtr).getSize;
  }

  alias GetLevelFuncType = extern(C) int function(GSocketControlMessage* message);

  @property GetLevelFuncType getLevel()
  {
    return (cast(GSocketControlMessageClass*)cPtr).getLevel;
  }

  alias GetTypeFuncType = extern(C) int function(GSocketControlMessage* message);

  @property GetTypeFuncType getType()
  {
    return (cast(GSocketControlMessageClass*)cPtr).getType;
  }

  alias SerializeFuncType = extern(C) void function(GSocketControlMessage* message, void* data);

  @property SerializeFuncType serialize()
  {
    return (cast(GSocketControlMessageClass*)cPtr).serialize;
  }
}
