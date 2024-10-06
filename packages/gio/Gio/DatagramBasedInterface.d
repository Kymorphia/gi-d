module Gio.DatagramBasedInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for socket-like objects which have datagram semantics,
 * following the Berkeley sockets API. The interface methods are thin wrappers
 * around the corresponding virtual methods, and no pre-processing of inputs is
 * implemented — so implementations of this API must handle all functionality
 * documented in the interface methods.
 */
class DatagramBasedInterface
{
  GDatagramBasedInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DatagramBasedInterface");

    cInstance = *cast(GDatagramBasedInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDatagramBasedInterface*)cPtr).gIface);
  }

  alias ReceiveMessagesFuncType = extern(C) int function(GDatagramBased* datagramBased, GInputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err);

  @property ReceiveMessagesFuncType receiveMessages()
  {
    return (cast(GDatagramBasedInterface*)cPtr).receiveMessages;
  }

  alias SendMessagesFuncType = extern(C) int function(GDatagramBased* datagramBased, GOutputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err);

  @property SendMessagesFuncType sendMessages()
  {
    return (cast(GDatagramBasedInterface*)cPtr).sendMessages;
  }

  alias CreateSourceFuncType = extern(C) GSource* function(GDatagramBased* datagramBased, GIOCondition condition, GCancellable* cancellable);

  @property CreateSourceFuncType createSource()
  {
    return (cast(GDatagramBasedInterface*)cPtr).createSource;
  }

  alias ConditionCheckFuncType = extern(C) GIOCondition function(GDatagramBased* datagramBased, GIOCondition condition);

  @property ConditionCheckFuncType conditionCheck()
  {
    return (cast(GDatagramBasedInterface*)cPtr).conditionCheck;
  }

  alias ConditionWaitFuncType = extern(C) bool function(GDatagramBased* datagramBased, GIOCondition condition, long timeout, GCancellable* cancellable, GError** _err);

  @property ConditionWaitFuncType conditionWait()
  {
    return (cast(GDatagramBasedInterface*)cPtr).conditionWait;
  }
}
